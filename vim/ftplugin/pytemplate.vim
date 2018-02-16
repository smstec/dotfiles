" pytemplate
"

call setline(1, 'from __future__ import division, print_function')
call setline(2, 'import click')
call setline(3, '')
call setline(4, '')
call setline(5, '@click.command(context_settings=dict(max_content_width=128))')
call setline(6, 'def main():')
call setline(7, '    pass')
call setline(8, '')
call setline(9, '')
call setline(10, 'if __name__ == "__main__":')
call setline(11, '    # pylint: disable=no-value-for-parameter')
call setline(12, '    main()')
