/*
*	Ｈｕｍａｎ６８ｋのファイルを、512 bytes / sector の
*	ディスクにコンバートする。
*
*使用法
*	512 byte / sector にフォーマットしたディスクドライブ１に入れて
*
*	conv filename
*/

/*コンパイルにはオプション -Y をつけること*/




#define BUF_SIZE (100 * 1024)


main(argc, argv)
int argc;
char **argv;
{
	int handle, fsize, pos;
	char *buf;

	if(argc < 2)
		error(1);

	if((buf = MALLOC(BUF_SIZE)) < 0)
		error(2);

	if((handle = OPEN(argv[1], 0)) <0)
		error(3);

	fsize = SEEK(handle, 0, 2);
	SEEK(handle, 0, 0);

	printf("file size = %d K bytes\n", ((fsize - 1) / 1024) + 1);

	pos = 0;
	while(fsize >= BUF_SIZE) {
		if((READ(handle, buf, BUF_SIZE) != BUF_SIZE)) {
			CLOSE(handle);
			error(4);
		}
		B_WRITE(0x91 * 256 + 0x70, rec_conv(pos), BUF_SIZE, buf);
		fsize -= BUF_SIZE;
		pos += BUF_SIZE;
	}
	if(fsize) {
		if((READ(handle, buf, fsize) != fsize)) {
			CLOSE(handle);
			error(4);
		}
		B_WRITE(0x91 * 256 + 0x70, rec_conv(pos), fsize, buf); /* no error check !!*/
	}
	CLOSE(handle);
}

rec_conv(pos)
int pos;
{
	register int t, s, h;

	t = (pos / 512) / 15;

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