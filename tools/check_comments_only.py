#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""check_comments_only.py —— 证明"只改了注释,没碰代码"。

用法:
    python tools/check_comments_only.py <基线目录> [--current <目录>] [文件...]

把基线目录与当前目录里的每个文件各自**剥掉注释**再逐字节比对。剥离是感知字符串
字面量的:Verilog 的 "..." 里出现的 // 不是注释,而是字符串内容。因此如果在
$display("...") 里动了字,这里会报出来,不会被误当作注释差异放过。

只处理本工程用到的四种文本:.v(Verilog)、.py(Python)、.tcl(Tcl)、.xdc(Tcl 方言)。

**失败即失败,不静默**:任何一个目标文件缺失、剥离报错、或一个文件都没比对到,
都直接判 FAIL。这个工具存在的意义就是"没发现问题",所以它绝不能在没真正比较的
情况下说 PASS —— 早先的两个 bug(快照写到另一个盘、文件名相对 CWD 解析)都属于
"静默跳过然后报通过",是最危险的失效模式,已由 fail-closed 设计堵住。

局限性(刻意保守 —— 宁可漏报也不误判):
  * Verilog 只剥 // 与 /* */,不处理 `define 的多行续行,也不解释宏;
  * Tcl 只在行首或分号后识别 #,因为 Tcl 里 # 只有在命令位置才是注释;
  * Python 只剥 #;docstring 当代码看待(本次不译它,故改动应当被抓出来)。
这些限制只会让"疑似代码差异"偏多(需要人工看一眼),不会让真实差异被藏起来。
"""

import argparse
import pathlib
import sys

SRC_EXTS = ('.v', '.vh', '.sv', '.py', '.tcl', '.xdc')


def strip_verilog(text):
    """剥掉 Verilog 的 // 与 /* */。字符串字面量 "..." 内的内容原样保留。

    注释所占的换行会被补回,所以行号与原来一一对应,差异能直接定位。
    """
    out = []
    i, n = 0, len(text)
    while i < n:
        c = text[i]
        # 字符串字面量:整段抄下来,内含的 // 或 /* 都不算注释
        if c == '"':
            out.append(c)
            i += 1
            while i < n:
                if text[i] == '\\' and i + 1 < n:      # 转义序列
                    out.append(text[i:i + 2])
                    i += 2
                    continue
                out.append(text[i])
                if text[i] == '"':
                    i += 1
                    break
                i += 1
            continue
        # 行注释
        if c == '/' and i + 1 < n and text[i + 1] == '/':
            i += 2
            while i < n and text[i] != '\n':
                i += 1
            continue
        # 块注释(Verilog 不嵌套)
        if c == '/' and i + 1 < n and text[i + 1] == '*':
            i += 2
            while i < n and not (text[i] == '*' and i + 1 < n and text[i + 1] == '/'):
                if text[i] == '\n':
                    out.append('\n')                   # 保住行号
                i += 1
            i += 2 if i < n else 0
            continue
        out.append(c)
        i += 1
    return ''.join(out)


def strip_python(text):
    """只剥 Python 的 # 注释。字符串字面量与 docstring 都当代码原样保留。

    docstring 是"像注释的代码",本次翻译不动它。不剥离它就等于把它当代码看待:
    万一手滑改到 docstring,这里会报出差异要求人工确认,而不是默默放过。
    严格 > 宽松 —— 这个工具存在的意义就是"没发现问题"。
    """
    out = []
    i, n = 0, len(text)
    while i < n:
        c = text[i]
        if c in '"\'':
            quote = c
            # 三引号字符串整体抄下来
            triple = text.startswith(quote * 3, i)
            closer = quote * 3 if triple else quote
            out.append(closer)
            i += len(closer)
            while i < n:
                if text[i] == '\\' and i + 1 < n:
                    out.append(text[i:i + 2])
                    i += 2
                    continue
                if text.startswith(closer, i):
                    out.append(closer)
                    i += len(closer)
                    break
                out.append(text[i])
                i += 1
            continue
        if c == '#':
            while i < n and text[i] != '\n':
                i += 1
            continue
        out.append(c)
        i += 1
    return ''.join(out)


def strip_tcl(text):
    """剥掉 Tcl 的 # 注释。

    Tcl 里 # 只有在命令位置才是注释(行首或 ; 之后);出现在参数中间时是普通字符,
    所以 "set x #y" 的 # 不是注释。这里按这个规则识别。
    """
    out = []
    for line in text.splitlines(keepends=True):
        body = line.rstrip('\r\n')
        eol = line[len(body):]
        if body.lstrip().startswith('#'):
            out.append(eol)
            continue
        if ';' in body:
            head, _, tail = body.partition(';')
            if tail.lstrip().startswith('#'):
                out.append(head + eol)
                continue
        out.append(line)
    return ''.join(out)


STRIPPERS = {'.v': strip_verilog, '.vh': strip_verilog, '.sv': strip_verilog,
             '.py': strip_python, '.tcl': strip_tcl, '.xdc': strip_tcl}


def normalize(text):
    """去掉逐行的行尾空白,以免删掉行内注释后残留的空格造成假差异。"""
    lines = [ln.rstrip() for ln in text.replace('\r\n', '\n').split('\n')]
    while lines and lines[-1] == '':
        lines.pop()
    return '\n'.join(lines)


def read_any(path):
    """按 UTF-8 读,失败再退回 GBK —— 工程里两种编码都出现过。"""
    raw = pathlib.Path(path).read_bytes()
    for enc in ('utf-8', 'gbk'):
        try:
            return raw.decode(enc)
        except UnicodeDecodeError:
            continue
    return raw.decode('utf-8', errors='replace')


def main(argv=None):
    ap = argparse.ArgumentParser(add_help=True, description=__doc__.split('\n')[0])
    ap.add_argument('baseline', help='基线目录')
    ap.add_argument('--current', default='.', help='当前目录(默认:. 即 CWD)')
    ap.add_argument('files', nargs='*', help='相对路径;省略则比对基线里的全部源码')
    # parse_intermixed_args 而不是 parse_args:位置参数 files 前面允许夹着 --current,
    # 否则 "基线 --current X a.v" 会被 argparse 当成用法错误直接退出(exit 2)。
    args = ap.parse_intermixed_args(argv)

    baseline = pathlib.Path(args.baseline).resolve()
    current = pathlib.Path(args.current).resolve()
    if not baseline.is_dir():
        print('FAIL: 基线目录不存在: %s' % baseline)
        return 2

    rels = args.files or sorted(
        str(p.relative_to(baseline)).replace('\\', '/')
        for p in baseline.rglob('*')
        if p.is_file() and p.suffix in SRC_EXTS)

    identical, changed, errors, not_source = [], [], [], []
    for rel in rels:
        rel = rel.replace('\\', '/')
        strip = STRIPPERS.get(pathlib.Path(rel).suffix)
        if strip is None:
            not_source.append(rel)
            continue
        base, cur = baseline / rel, current / rel
        # 缺失一律当错误 —— 绝不能因为"没找到"而少比一个文件还说 PASS
        if not base.exists():
            errors.append('%s: 基线里不存在' % rel)
            continue
        if not cur.exists():
            errors.append('%s: 当前目录里不存在 (%s)' % (rel, cur))
            continue
        try:
            a = normalize(strip(read_any(base)))
            b = normalize(strip(read_any(cur)))
        except Exception as exc:                       # noqa: BLE001
            errors.append('%s: 剥离失败 %s' % (rel, exc))
            continue
        (identical if a == b else changed).append(rel if a == b else (rel, a, b))

    print('剥掉注释后逐字节比对')
    print('  基线: %s' % baseline)
    print('  当前: %s' % current)
    print('  代码相同: %d 个文件' % len(identical))
    if not_source:
        print('  非源码(已跳过): %s' % ', '.join(not_source))
    if errors:
        print('  错误: ')
        for e in errors:
            print('    - %s' % e)

    # fail-closed:比对数为 0、或有任何错误,都不允许说 PASS
    if errors or not identical:
        print('\n结果: FAIL —— %s'
              % ('存在错误,未能完成比对' if errors else '一个文件都没比对到'))
        return 1
    if changed:
        print('\n结果: FAIL —— 以下文件的非注释内容有差异(必须人工确认):')
        for rel, a, b in changed:
            print('\n### %s' % rel)
            la, lb = a.split('\n'), b.split('\n')
            shown = 0
            for k in range(max(len(la), len(lb))):
                x = la[k] if k < len(la) else '<无此行>'
                y = lb[k] if k < len(lb) else '<无此行>'
                if x != y:
                    shown += 1
                    if shown <= 10:
                        print('  基线 L%d: %s' % (k + 1, x.strip()[:100]))
                        print('  现在 L%d: %s' % (k + 1, y.strip()[:100]))
            if shown > 10:
                print('  ... 另有 %d 处' % (shown - 10))
        return 1

    print('\n结果: PASS —— 没有任何文件的代码部分发生变化,改动全部落在注释里。')
    return 0


if __name__ == '__main__':
    sys.exit(main())
