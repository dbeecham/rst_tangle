#include <stdio.h>
#include <unistd.h>

%%{
    machine tangle;

    action debug {
        int b = write(STDOUT_FILENO, p, 1); (void)b;
    }



    code_line = (
                    (
                        '   '
                        (any* -- '\n')$debug
                        '\n' $debug
                    )
                    |
                    (
                        [ \t]*
                        '\n' $debug
                    )
                );



    code_lines := code_line* $err{ fhold; fgoto main; };

    option_lines := (
                      '\n' @{ fgoto code_lines; }
                      |
                      ('   :' (any* -- '\n') '\n')
                   )* $err{ fhold; fgoto main; };

    language = 'c';

    code_block = '.. code'
                 '-block'?
                 '::'
                 ' '
                 language
                 '\r'?
                 '\n' @{ fgoto option_lines; };

    main := code_block @err{fgoto main;};

    write data;

}%%

int main(int argc, char *argv[]) {
    int bytes_read = 0;
    char buf[128];
    int stack[8];
    int top = 0;
    char *p, *pe, *eof = 0;
    int cs;

    %% write init;

    bytes_read = fread(buf, 1, 128, stdin);
    while (bytes_read > 0) {
 
        p = buf;
        pe = buf + bytes_read;

        %% write exec;

        bytes_read = fread(buf, 1, 128, stdin);
    }
}
