/*
*	512 bytes / sector の Ｍａｃ　Ｄｉｓｋをコピーする。
*
*使用法
*	512 byte / sector にフォーマットしたディスクドライブ１に入れて
*
*	Mcopy
*/

/*コンパイルにはオプション -Y をつけること*/




#define BUF_SIZE (100 * 1024)


main(argc, argv)
int argc;
char **argv;
{
	int handle, fsize, pos;
	char *buf;

	if((buf = MALLOC(BUF_SIZE)) < 0)
		error(2);

	printf("ドライブ０＞＞１のＣＯＰＹします。よろしいですね（中止＾Ｃ）");
	getch();
	printf("\n");

	fsize = 819200;
	pos = 0;
	while(fsize >= BUF_SIZE) {
		B_READ(0x90 * 256 + 0x70, rec_conv(pos), BUF_SIZE, buf);
		B_WRITE(0x91 * 256 + 0x70, rec_conv(pos), BUF_SIZE, buf);
		fsize -= BUF_SIZE;
		pos += BUF_SIZE;
	}
	if(fsize) {
		B_READ(0x90 * 256 + 0x70, rec_conv(pos), fsize, buf); /* no error check !!*/
		B_WRITE(0x91 * 256 + 0x70, rec_conv(pos), fsize, buf); /* no error check !!*/
	}
	printf("コピーは完了しました\n");
}

rec_conv(pos)
int pos;
{
	register int t, s, h;

	t = (pos / 512) / 15;

	printf("track = %3.3d\r", t);


	s = (pos / 512) % 15 + 1;

	h = t % 2;
	h *= 256;

	t /= 2;
	t *= 256 * 256;

	return(0x02000000 + t + h + s);
}


error(n)
int n;
{
	static *err_mes[] = {
				"",
				"commnad error!",
				"no memory!",
				"file open error!",
				"file read error!"
			};

	printf("%s\n", err_mes[n]);
	exit(1);
}
