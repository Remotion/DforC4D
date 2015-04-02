module sandox;

import c4d_string;
import c4d_general;

//import terminal;

version(Windows)
{
	import core.sys.windows.windows;
	import std.windows.syserror;

	extern(Windows){

		/* Logical Font */
		enum LF_FACESIZE =        32;


		struct _CONSOLE_FONT_INFOEX {
			ULONG cbSize = _CONSOLE_FONT_INFOEX.sizeof; //important 
			DWORD nFont = 0;
			COORD dwFontSize = {0,0};
			UINT FontFamily = 0;
			UINT FontWeight = 0;
			WCHAR FaceName[LF_FACESIZE];
		};
		
		//CONSOLE_FONT_INFOEX, *PCONSOLE_FONT_INFOEX;
		alias PCONSOLE_FONT_INFOEX = _CONSOLE_FONT_INFOEX*;

		BOOL GetCurrentConsoleFontEx( HANDLE hConsoleOutput,
									  BOOL bMaximumWindow,
									  /*PCONSOLE_FONT_INFOEX*/_CONSOLE_FONT_INFOEX* lpConsoleCurrentFontEx);

		BOOL SetCurrentConsoleFontEx( HANDLE hConsoleOutput,
									 BOOL bMaximumWindow,
									 PCONSOLE_FONT_INFOEX lpConsoleCurrentFontEx);


		struct _CONSOLE_FONT_INFO {
			DWORD  nFont;
			COORD  dwFontSize;
		}; //CONSOLE_FONT_INFO, *PCONSOLE_FONT_INFO;

		alias PCONSOLE_FONT_INFO = _CONSOLE_FONT_INFO*;

		BOOL GetCurrentConsoleFont( HANDLE hConsoleOutput,
								    BOOL bMaximumWindow,
								    PCONSOLE_FONT_INFO lpConsoleCurrentFont);


		struct CONSOLE_INFO
		{
			ULONG Length = CONSOLE_INFO.sizeof;
			COORD ScreenBufferSize;
			COORD WindowSize;
			ULONG WindowPosX;
			ULONG WindowPosY;
			COORD FontSize;
			ULONG FontFamily;
			ULONG FontWeight;
			WCHAR FaceName[32];
			ULONG CursorSize;
			ULONG FullScreen;
			ULONG QuickEdit;
			ULONG AutoPosition;
			ULONG InsertMode;
			USHORT ScreenColors;
			USHORT PopupColors;
			ULONG HistoryNoDup;
			ULONG HistoryBufferSize;
			ULONG NumberOfHistoryBuffers;
			COLORREF ColorTable[16];
			ULONG CodePage;
			HWND Hwnd;
			WCHAR ConsoleTitle[0x100];
		} ;

		struct CONSOLE_SCREEN_BUFFER_INFOEX {
			ULONG      cbSize = CONSOLE_SCREEN_BUFFER_INFOEX.sizeof; //The size of this structure, in bytes.
			COORD      dwSize;
			COORD      dwCursorPosition;
			WORD       wAttributes = 0x0F; // default black bg, white text
			SMALL_RECT srWindow;
			COORD      dwMaximumWindowSize;
			WORD       wPopupAttributes = 0xF5; //
			BOOL       bFullscreenSupported;
			COLORREF   ColorTable[16]; //An array of COLORREF values that describe the console's color settings.
		}
		alias PCONSOLE_SCREEN_BUFFER_INFOEX = CONSOLE_SCREEN_BUFFER_INFOEX*;




		BOOL GetConsoleScreenBufferInfoEx(HANDLE hConsoleOutput,
											PCONSOLE_SCREEN_BUFFER_INFOEX lpConsoleScreenBufferInfoEx );


		BOOL SetConsoleScreenBufferInfoEx(HANDLE hConsoleOutput,
											PCONSOLE_SCREEN_BUFFER_INFOEX lpConsoleScreenBufferInfoEx );

		//void SetConsolePalette(COLORREF palette[], int fontX, int fontY, const(WCHAR)/*wchar_t*/ *fontName);
		//void GetConsoleSizeInfo(CONSOLE_INFO *pci, HANDLE hOutput);

/+
		//	Fill the CONSOLE_INFO structure with information
		//  about the current console window
		void GetConsoleSizeInfo(CONSOLE_INFO *pci)
		{
			CONSOLE_SCREEN_BUFFER_INFO csbi;

			HANDLE hConsoleOut = GetStdHandle(STD_OUTPUT_HANDLE);

			GetConsoleScreenBufferInfo(hConsoleOut, &csbi);

			pci.ScreenBufferSize  = csbi.dwSize;
			pci.WindowSize.X	  = csbi.srWindow.Right - csbi.srWindow.Left + cast(USHORT)1;
			pci.WindowSize.Y	  = csbi.srWindow.Bottom - csbi.srWindow.Top + cast(USHORT)1;
			pci.WindowPosX	      = csbi.srWindow.Left;
			pci.WindowPosY		  = csbi.srWindow.Top;
		}
		
		void SetConsolePalette(COLORREF palette[16])
		{
			CONSOLE_INFO ci;// = { sizeof(ci) };
			int i;
			HWND hwndConsole = GetConsoleWindow();

			// get current size/position settings rather than using defaults..
			GetConsoleSizeInfo(&ci);

			// set these to zero to keep current settings
			ci.FontSize.X				= 0;//8;
			ci.FontSize.Y				= 0;//12;
			ci.FontFamily				= 0;//0x30;//FF_MODERN|FIXED_PITCH;//0x30;
			ci.FontWeight				= 0;//0x400;
			//lstrcpyW(ci.FaceName, L"Terminal");
			ci.FaceName[0]				= '\0';

			ci.CursorSize				= 25;
			ci.FullScreen				= FALSE;
			ci.QuickEdit				= TRUE;
			ci.AutoPosition				= 0x10000;
			ci.InsertMode				= TRUE;
			ci.ScreenColors				= MAKEWORD(0x7, 0x0);
			ci.PopupColors				= MAKEWORD(0x5, 0xf);

			ci.HistoryNoDup				= FALSE;
			ci.HistoryBufferSize		= 50;
			ci.NumberOfHistoryBuffers	= 4;

			// colour table
			for(i = 0; i < 16; i++)
				ci.ColorTable[i] = palette[i];

			ci.CodePage					= 0;//0x352;
			ci.Hwnd						= hwndConsole;

			const(WCHAR)* gg = ""w.ptr;
			lstrcpyW(ci.ConsoleTitle, gg/*L""*/);

			SetConsoleInfo(hwndConsole, &ci);
		}
		+/

		//BOOL SetConsolePalette(HANDLE hConsoleOutput,
		//						HPALETTE hPalette,
		//						UINT dwUsage);
	}

	enum
	{
		WIN_STD_INPUT_HANDLE   = -10,
		WIN_STD_OUTPUT_HANDLE  = -11,
		WIN_STD_ERROR_HANDLE   = -12,
	};

	//------------------------------------------------------------------------------------------------------------------------------------------------------------
	/* These are the first 16 colors anyways. You test the other hundreds yourself.
	After 15 they are all combos of different color text/backgrounds. */
	enum ConsoleColor { DBLUE=1,GREEN,GREY,DRED,DPURP,BROWN,LGREY,DGREY,BLUE,LIMEG,TEAL,RED,PURPLE,YELLOW,WHITE,B_B };

	//------------------------------------------------------------------------------------------------------------------------------------------------------------
	bool GeSetConsoleColor(UInt16 new_color = ConsoleColor.LGREY, bool bold = false, bool bg = false) //LGREY is default color ?
	{
		//if (bold) new_color |= BACKGROUND_INTENSITY; //128
		if (bg) { ///TODO <<<
			new_color |= BACKGROUND_RED;
			if (bold) new_color |= BACKGROUND_INTENSITY; 
		} else {
			if (bold) new_color |= FOREGROUND_INTENSITY;
		}
		HANDLE hcon = GetStdHandle(WIN_STD_OUTPUT_HANDLE);
		if(hcon) return cast(bool)SetConsoleTextAttribute(hcon,new_color);
		return false;
	}
	// ----------------------------------------------------------------------------------------------------
	void HideConsole() {
		ShowWindow( GetConsoleWindow(), SW_HIDE );
	}
	// ----------------------------------------------------------------------------------------------------
	void RestoreConsole() {
		ShowWindow( GetConsoleWindow(), SW_RESTORE );
	}
}

extern(Windows):
unittest
{
	import core.stdc.stdio;

	const string code = import("test.txt");
	mixin(code);

	mixin( import("test.txt") );


	// Even the following code runs out of memory on my machine:
	/*
	int foo(){
		foreach(i;0..100000000){} //consumes about 9 GB of RAM !!!
		return 2;
	}
	pragma(msg, foo());
	*/

	//string st = cast(string)42;

	/+
	String str1;// = "test";

	printf(">>> str1 %i %i %p %p \n",str1.m_size,str1.m_len,str1.m_txt,str1.m_future_enhancements);

	str1 = "1"; GePrint(str1);
	String str2 = str1;
	printf(">>> str1 %i %i %p %p \n",str1.m_size,str1.m_len,str1.m_txt,str1.m_future_enhancements);
	printf(">>> str2 %i %i %p %p \n",str2.m_size,str2.m_len,str2.m_txt,str2.m_future_enhancements);

	str1 = "test"; GePrint(str1);
	printf(">>> str1 %i %i %p %p \n",str1.m_size,str1.m_len,str1.m_txt,str1.m_future_enhancements);
 
 
	str1[1] = 'Q';
	GePrint(str1);

	str1[-1] = 'Q';
	GePrint(str1);

	str1[100] = 'Q';
	GePrint(str1);
	+/
	/*
	auto Ubc = str1.GetDataPtrCopy();
	Ubc[0] = 64;
	str1.SetUcBlock(Ubc,str1.GetLength());
	GePrint(str1);
	printf(" len  %i \n",str1.GetLength());
	printf(">>> str1 %i %i %p %p \n",str1.m_size,str1.m_len,str1.m_txt,str1.m_future_enhancements);
	*/

	//HideConsole();
	//RestoreConsole();

	//GeSetConsoleColor(ConsoleColor.DRED,true);
	//printf(" test \n");


/+
	HANDLE hcon = GetStdHandle(WIN_STD_OUTPUT_HANDLE);

	_CONSOLE_FONT_INFOEX  font;
	//font.cbSize = 40;

	_CONSOLE_FONT_INFO fi;
	BOOL r0 = GetCurrentConsoleFont(hcon,0,&fi);
	printf(" test %i  %i %i \n",r0,fi.nFont,fi.dwFontSize);

	BOOL r1 = GetCurrentConsoleFontEx(hcon,0,&font);
	printf(" test %i  %i %i \n",r1,font.cbSize,font.nFont);
	printf(" Err %i \n",GetLastError());

	BOOL r2 = SetCurrentConsoleFontEx(hcon,0,&font);
	printf(" test %i \n",r2);
	printf(" Err %i \n",GetLastError());

	//const(CHAR)* title = "TEST".ptr;
	///SetConsoleTitleA(title); //OK !!!

	CONSOLE_SCREEN_BUFFER_INFO csbi;
	BOOL r3 = GetConsoleScreenBufferInfo(hcon,&csbi);
	printf(" test %i  %i  \n",r3,csbi.wAttributes);
/+
	COLORREF palette[16] = [
		0x00000000, 0x00800000, 0x00008000, 0x00808000,
		0x00000080, 0x00800080, 0x00008080, 0x00c0c0c0,
		0x00808080, 0x00ff0000, 0x0000ff00, 0x00ffff00,
		0x000000ff, 0x00ff00ff, 0x0000ffff, 0x00ffffff
	];

	const(WCHAR)* gg = ""w.ptr;
	SetConsolePalette(palette, 6, 6, gg);
+/

	//BOOL r4 = SetConsolePalette(hcon,null,0);
	//printf(" Err %i \n",GetLastError());


	_CONSOLE_FONT_INFOEX console_info;

	//retrieve info
	GetCurrentConsoleFontEx( GetStdHandle(STD_OUTPUT_HANDLE), false, &console_info);

	//adjust heights
	console_info.dwFontSize.X = 14;
	console_info.dwFontSize.Y = 14;

	//set info
	SetCurrentConsoleFontEx( GetStdHandle(STD_OUTPUT_HANDLE), false, &console_info);

	//printf(" Err %i \n",GetLastError());


	CONSOLE_SCREEN_BUFFER_INFOEX csbi_ex;
	GetConsoleScreenBufferInfoEx(hcon,&csbi_ex);
	//printf(" Err %i \n",GetLastError());

	printf("ColorTable %x %x %x %x \n",csbi_ex.wAttributes,csbi_ex.wPopupAttributes,csbi_ex.ColorTable[0],csbi_ex.ColorTable[0]);

	COLORREF palette[16] = [
		0x00000000, 0x00800000, 0x00008000, 0x00808000,
		0x00000080, 0x00800080, 0x00008080, 0x00c0c0c0,
		0x00808080, 0x00ff0000, 0x0000ff00, 0x00ffff00,
		0x000000ff, 0x00ff00ff, 0x0000ffff, 0x00ffffff
	];

	csbi_ex.ColorTable = palette; //restore dafault palette

	csbi_ex.wAttributes		 = 0x0F;
	csbi_ex.wPopupAttributes = 0xF5;

	printf(" %i %i %i %i \n",
		   csbi_ex.srWindow.Left,
		   csbi_ex.srWindow.Top,
		   csbi_ex.srWindow.Right,
		   csbi_ex.srWindow.Bottom);
	//csbi_ex.srWindow.Left = 0;
	csbi_ex.srWindow.Right = 160;

	SetConsoleScreenBufferInfoEx(hcon,&csbi_ex);
	//printf(" Err %i \n",GetLastError());
+/
}