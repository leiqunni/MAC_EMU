/*
*	ドライブ１のディスクを 512 bytes /sector でフォーマットする
*
*使用法
*	ドライブ１にフォーマットするディスクを入れて
*
*	f512
*
*/	

/*コンパイルにはオプション -Y をつけること*/

/*注意　エラーチェックは全くしていない！！*/




#define SEC_LEN 2
#define MAX_SECTOR 15
#define MAX_TRACK 160


main()
{
	static char format_data[4 * MAX_SECTOR];

	int track, i;
	char *ptr;

	printf("\007ドライブ１のディスクをフォーマットします。よろしいですね（中止＾Ｃ）");
	getch();
	printf("\n");


	for(track = 0; track < MAX_TRACK; ++track) {
		for(i = 0; i < MAX_SECTOR; ++i) {
			ptr = format_data + i * 4;
			*ptr++ = track / 2;
			*ptr++ = track % 2;
			*ptr++ = i + 1;
			*ptr = SEC_LEN;
		}
		B_FORMAT(0x91 * 256 + 0x70, SEC_LEN * 0x01000000 + (track / 2) * 0x00010000
			 + (track % 2) * 0x00000100 + 1, 4 * MAX_SECTOR, format_data);
		printf("track = %3.3d\r", track);
	}
	printf("フォーマットは完了しました\n");
}
