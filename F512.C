/*
*	�h���C�u�P�̃f�B�X�N�� 512 bytes /sector �Ńt�H�[�}�b�g����
*
*�g�p�@
*	�h���C�u�P�Ƀt�H�[�}�b�g����f�B�X�N������
*
*	f512
*
*/	

/*�R���p�C���ɂ̓I�v�V���� -Y �����邱��*/

/*���Ӂ@�G���[�`�F�b�N�͑S�����Ă��Ȃ��I�I*/




#define SEC_LEN 2
#define MAX_SECTOR 15
#define MAX_TRACK 160


main()
{
	static char format_data[4 * MAX_SECTOR];

	int track, i;
	char *ptr;

	printf("\007�h���C�u�P�̃f�B�X�N���t�H�[�}�b�g���܂��B��낵���ł��ˁi���~�O�b�j");
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
	printf("�t�H�[�}�b�g�͊������܂���\n");
}
