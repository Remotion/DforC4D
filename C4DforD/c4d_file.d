
module c4d_file;

import c4d;
import c4d_os;
import c4d_filename;
import c4d_main;

import core.stdc.stdio : printf;

//#define FnCall(fnc) (this->*C4DOS.Fn->fnc)
//#define FlCall(fnc) (this->*C4DOS.Fl->fnc)
//#define HfCall(fnc) (this->*C4DOS.Hf->fnc)

//void FlCall(F)(F fnc) { return (C4DOS.Fl.fnc(this)); }

/*auto FlCall(F, Args...) (F fnc,Args args) { 
	pragma(msg,F,fnc);
	return C4DOS.Fl.fnc(this,args);
}*/
/*
auto FlCall(alias F, Args...) (Args args) { 
	pragma(msg,F);
	//return C4DOS.Fl.F(this,args);
	return 0;
}*/

/*auto FlCall(alias F)() { 
	pragma(msg,F);

}*/
/*
void FlCall_0( F)() { 
	//pragma(msg,F);
}
mixin template FlCall_1( F) { 
	pragma(msg,F);
}

unittest {
	FlCall_0!(Open)();
	mixin FlCall_1!(Open);
}
*/

//? FlCall\((\w+)\)\s\(\)
//? C4DOS.Fl.$1(&this )

//? FlCall\((\w+)\)\s\(
//? C4DOS.Fl.$1(&this, 

//extern /* extern(C)*/ /*shared*/ /*__gshared*/ Filename* path_storage;

Filename GeGetPluginPath() { //TODO >>>
	/*import c4d_general : GePrint;
	if(path_storage && path_storage.GetDirectory().Content()) {
		printf(" path_storage is ok \n");
		//GePrint(path_storage.GetDirectory().GetString());
	}*/

	return path_storage ? path_storage.GetDirectory() : Filename();
}

Bool GeFExist()(auto ref const Filename name, Bool isdir = false){
	return C4DOS.Ge.FExist(&name, isdir);
}
/*
Bool GeFExist(ref const Filename name, Bool isdir){
	return C4DOS.Ge.FExist(&name, isdir);
}
Bool GeFExist(in Filename name, Bool isdir){
	return C4DOS.Ge.FExist(&name, isdir);
}
*/

Bool GeSearchFile(ref const Filename directory, ref const Filename name, Filename* found){
	return C4DOS.Ge.SearchFile(&directory, &name, found);
}

Bool GeFKill(ref const Filename name, Int32 flags = 0){
	return C4DOS.Ge.FKill(&name, flags);
}

Bool GeFCopyFile(ref const Filename source, ref const Filename dest, Int32 flags){
	return C4DOS.Ge.FCopyFile(&source, &dest, flags);
}

Bool GeFRename(ref const Filename source, ref const Filename dest){
	return C4DOS.Ge.FRename(&source, &dest);
}

Bool GeFMove(ref const Filename source, ref const Filename dest){
	return C4DOS.Ge.FMove(source, dest);
}

Bool GeFCreateDir(ref const Filename name){
	return C4DOS.Ge.FCreateDir(&name);
}


//=============================================================================
struct BaseFile
{
private:
	@disable  this(); // BaseFile();
	@disable ~this() {}; //~BaseFile();

public:
/+
	// Open a file, name is of type filename
	// mode					: read, write or readwrite
	// error_dialog	: display any errors in dialogs
	// order				:	little or big endian
	// type,creator	: MAC file types
	Bool Open(ref const Filename name, FILEOPEN mode = FILEOPEN_READ, FILEDIALOG error_dialog = FILEDIALOG_IGNOREOPEN, BYTEORDER order = BYTEORDER_MOTOROLA, Int32 type = MACTYPE_CINEMA, Int32 creator = MACCREATOR_CINEMA);

	// Closes a file - automatically called when BaseFile is destructed
	Bool Close();

	// Change byte order while reading - little or big endian allowed as parameter
	void SetOrder(BYTEORDER order);

	// Read len bytes
	Int ReadBytes(void* data, Int len, Bool just_try_it = false);

	// Write len bytes
	Bool WriteBytes(const void* data, Int len);

	// Tries to read len bytes - if less bytes were read no error state is set
	// the number of read bytes is returned
	Int TryReadBytes(void* data, Int len);

	// Seek - returns error
	Bool Seek(Int64 pos, FILESEEK mode = FILESEEK_RELATIVE);

	// Return actual file position
	Int64 GetPosition();

	// Return file length
	Int64 GetLength();

	// Returns the base file location
	LOCATION GetLocation() const;

	// Return file error
	FILEERROR GetError() const;

	// Manually set file error
	void SetError(FILEERROR error);

	Bool ReadChar (Char* v);
	Bool ReadUChar(UChar* v);
	Bool ReadInt16 (Int16* v);
	Bool ReadUInt16(UInt16* v);
	Bool ReadInt32 (Int32* v);
	Bool ReadUInt32(UInt32* v);
	Bool ReadFloat32(Float32* v);
	Bool ReadFloat64(Float64* v);
	Bool ReadInt64(Int64* v);
	Bool ReadUInt64(UInt64* v);
	Bool ReadFilename(Filename* v);
	Bool ReadBool(Bool* v);
	Bool ReadString(String* v);
	Bool ReadVector32(Vector32* v);
	Bool ReadVector64(Vector64* v);
	Bool ReadMatrix32(Matrix32* v);
	Bool ReadMatrix64(Matrix64* v);

	Bool WriteChar (Char v);
	Bool WriteUChar(UChar v);
	Bool WriteInt16 (Int16 v);
	Bool WriteUInt16(UInt16 v);
	Bool WriteInt32 (Int32 v);
	Bool WriteUInt32(UInt32 v);
	Bool WriteFloat32(Float32 v);
	Bool WriteFloat64(Float64 v);
	Bool WriteInt64(Int64 v);
	Bool WriteUInt64(UInt64 v);
	Bool WriteFilename(ref const Filename v);
	Bool WriteBool(Bool v);
	Bool WriteString(ref const String v);
	Bool WriteVector32(ref const Vector32 v);
	Bool WriteVector64(ref const Vector64 v);
	Bool WriteMatrix32(ref const Matrix32 v);
	Bool WriteMatrix64(ref const Matrix64 v);
+/
	static BaseFile* Alloc(){	return C4DOS.Fl.Alloc();	}
	static void Free(ref BaseFile *fl){	/*printf("BaseFile::Free");*/ C4DOS.Fl.Free(fl);	fl = null;	}


	Bool Open(ref const Filename name, FILEOPEN mode = FILEOPEN_READ, FILEDIALOG error_dialog = FILEDIALOG_IGNOREOPEN, BYTEORDER order = BYTEORDER_MOTOROLA, Int32 type = MACTYPE_CINEMA, Int32 creator = MACCREATOR_CINEMA)	{
		//return FlCall(Open)(name, mode, error_dialog, order, type, creator);
		return C4DOS.Fl.Open(&this,name, mode, error_dialog, order, type, creator);
	}

	Bool Close()	{
		return C4DOS.Fl.Close(&this );
	}

	void SetOrder(BYTEORDER order)	{
		C4DOS.Fl.SetOrder(&this, order);
	}

	Int ReadBytes(void* data, Int len, Bool just_try_it = false)	{
		return C4DOS.Fl.ReadBytes(&this, data, len, just_try_it);
	}

	Bool WriteBytes(const void* data, Int len)	{
		return C4DOS.Fl.WriteBytes(&this, data, len);
	}

	Int TryReadBytes(void* data, Int len)	{
		return C4DOS.Fl.ReadBytes(&this, data, len, true);
	}

	Bool Seek(Int64 pos, FILESEEK mode = FILESEEK_RELATIVE)	{
		return C4DOS.Fl.Seek(&this, pos, mode);
	}

	Int64 GetPosition()	{
		return C4DOS.Fl.GetPosition(&this );
	}

	Int64 GetLength()	{
		return C4DOS.Fl.GetLength(&this );
	}

	LOCATION GetLocation() const	{
		return C4DOS.Fl.GetLocation(&this );
	}

	FILEERROR GetError() const	{
		return C4DOS.Fl.GetError(&this );
	}

	void SetError(FILEERROR error)	{
		C4DOS.Fl.SetError(&this, error);
	}

	Bool ReadChar (Char* v)	{
		return C4DOS.Fl.ReadChar(&this, v);
	}

	Bool ReadUChar(UChar* v)	{
		return C4DOS.Fl.ReadUChar(&this, v);
	}

	Bool ReadInt16 (Int16* v)	{
		return C4DOS.Fl.ReadInt16(&this, v);
	}

	Bool ReadUInt16(UInt16* v)	{
		return C4DOS.Fl.ReadUInt16(&this, v);
	}

	Bool ReadInt32 (Int32* v)	{
		return C4DOS.Fl.ReadInt32(&this, v);
	}

	Bool ReadUInt32(UInt32* v)	{
		return C4DOS.Fl.ReadUInt32(&this, v);
	}

	Bool ReadInt64(Int64* v)	{
		return C4DOS.Fl.ReadInt64(&this, v);
	}

	Bool ReadUInt64(UInt64* v)	{
		return C4DOS.Fl.ReadUInt64(&this, v);
	}

	Bool ReadFloat64(Float64* v)	{
		return C4DOS.Fl.ReadFloat64(&this, v);
	}

	Bool ReadFloat32(Float32* v)	{
		return C4DOS.Fl.ReadFloat32(&this, v);
	}

	Bool ReadVector32(Vector32* v)	{
		return ReadFloat32(&v.x) && ReadFloat32(&v.y) && ReadFloat32(&v.z);
	}

	Bool WriteVector32(ref const Vector32 v)
	{
		return WriteFloat32(v.x) && WriteFloat32(v.y) && WriteFloat32(v.z);
	}

	Bool ReadVector64(Vector64* v)	{
		return ReadFloat64(&v.x) && ReadFloat64(&v.y) && ReadFloat64(&v.z);
	}

	Bool WriteVector64(ref const Vector64 v)	{
		return WriteFloat64(v.x) && WriteFloat64(v.y) && WriteFloat64(v.z);
	}

	Bool ReadMatrix32(Matrix32* v)	{
		return ReadVector32(&v.off) && ReadVector32(&v.v1) && ReadVector32(&v.v2) && ReadVector32(&v.v3);
	}

	Bool WriteMatrix32(ref const Matrix32 v)	{
		return WriteVector32(v.off) && WriteVector32(v.v1) && WriteVector32(v.v2) && WriteVector32(v.v3);
	}

	Bool ReadMatrix64(Matrix64* v)	{
		return ReadVector64(&v.off) && ReadVector64(&v.v1) && ReadVector64(&v.v2) && ReadVector64(&v.v3);
	}

	Bool WriteMatrix64(ref const Matrix64 v)	{
		return WriteVector64(v.off) && WriteVector64(v.v1) && WriteVector64(v.v2) && WriteVector64(v.v3);
	}
/*
	Bool ReadString(String* v)	{
		Int32 len = 0;
		Char* c = nullptr;

		if (!ReadInt32(&len))
			return false;
		if (!len)
		{
			*v = String(); return true;
		}

		c = NewMemClear(Char, len);
		if (!c)
		{
			SetError(FILEERROR_OUTOFMEMORY);
			return false;
		}
		if (!ReadBytes(c, len))
		{
			DeleteMem(c);
			return false;
		}

		v.SetCString(c, len - 1);
		DeleteMem(c);

		return true;
	}

	Bool ReadFilename(Filename* v)	{
		String str;
		if (!ReadString(&str))
			return false;
		v.SetString(str);
		return true;
	}
*/
	Bool ReadBool(Bool* v)	{
		Char c;
		if (!ReadChar(&c))
			return false;
		*v = c != 0;
		return true;
	}

	Bool WriteBool(Bool v)	{
		return WriteChar(Char(v != 0));
	}
/*
	Bool WriteString(ref const String v)	{
		Bool	ok;
		Int32 len = v.GetCStringLen() + 1;
		Char* mem = NewMemClear(Char, len);
		if (!mem)
		{
			SetError(FILEERROR_OUTOFMEMORY);
			return false;
		}

		v.GetCString(mem, len);
		ok = WriteInt32(len) && WriteBytes(mem, len);
		DeleteMem(mem);

		return ok;
	}

	Bool WriteFilename(ref const Filename v)	{
		return WriteString(v.GetString());
	}
*/
	Bool WriteChar (Char v)	{
		return C4DOS.Fl.WriteChar(&this, v);
	}

	Bool WriteUChar(UChar v)	{
		return C4DOS.Fl.WriteUChar(&this, v);
	}

	Bool WriteInt16 (Int16 v)	{
		return C4DOS.Fl.WriteInt16(&this, v);
	}

	Bool WriteUInt16(UInt16 v)	{
		return C4DOS.Fl.WriteUInt16(&this, v);
	}

	Bool WriteInt32 (Int32 v)	{
		return C4DOS.Fl.WriteInt32(&this, v);
	}

	Bool WriteInt64(Int64 v)	{
		return C4DOS.Fl.WriteInt64(&this, v);
	}

	Bool WriteUInt32(UInt32 v)	{
		return C4DOS.Fl.WriteUInt32(&this, v);
	}

	Bool WriteUInt64(UInt64 v)	{
		return C4DOS.Fl.WriteUInt64(&this, v);
	}

	Bool WriteFloat64(Float64 v)	{
		return C4DOS.Fl.WriteFloat64(&this, v);
	}

	Bool WriteFloat32(Float32 v)	{
		return C4DOS.Fl.WriteFloat32(&this, v);
	}

};



/+
//=============================================================================
struct AESFile : public BaseFile
{
private:
	AESFile();
	~AESFile();

public:
	// Open a file, name is of type filename
	// mode					: read, write or readwrite
	// error_dialog	: display any errors in dialogs
	// order				:	little or big endian
	// type,creator	: MAC file types
	Bool Open(ref const Filename name, const char* key, Int32 keylen, Int32 blocksize, UInt32 aes_flags, FILEOPEN mode = FILEOPEN_READ, FILEDIALOG error_dialog = FILEDIALOG_IGNOREOPEN, BYTEORDER order = BYTEORDER_MOTOROLA, Int32 type = MACTYPE_CINEMA, Int32 creator = MACCREATOR_CINEMA);

	// checks if encrypt is the encrypted version of decrypt
	static Bool CheckEncryption(ref const Filename encrypt, ref const Filename decrypt, const char* key, Int32 keylen, Int32 blocksize);

	static AESFile* Alloc(void);
	static void Free(AESFile*& fl);
};
+/

//=============================================================================
struct LocalFileTime
{
public:
	UInt16 year;
	UInt16 month;
	UInt16 day;
	UInt16 hour;
	UInt16 minute;
	UInt16 second;

	void Init() {
		year = month = day = hour = minute = second = 0;
	}

	// > 0: t0 > t1
	// = 0: t0 == t1
	// < 0: t0 < t1
	Int32	Compare(ref const LocalFileTime  t0, ref const LocalFileTime  t1)
	{
		Int32	result;
		result = t0.year - t1.year;
		if (result == 0)
		{
			result = t0.month - t1.month;
			if (result == 0)
			{
				result = t0.day - t1.day;
				if (result == 0)
				{
					result = t0.hour - t1.hour;
					if (result == 0)
					{
						result = t0.minute - t1.minute;
						if (result == 0)
							result = t0.second - t1.second;
					}
				}
			}
		}
		return result;
	}
/*
	Bool operator == (ref const LocalFileTime  x)
	{
		return year == x.year && month == x.month && day == x.day && hour == x.hour && minute == x.minute && second == x.second;
	}

	Bool operator != (ref const LocalFileTime  x)
	{
		return year != x.year || month != x.month || day != x.day || hour != x.hour || minute != x.minute || second != x.second;
	}

	Bool operator > (ref const LocalFileTime  x)
	{
		return Compare(*this, x) > 0;
	}

	Bool operator < (ref const LocalFileTime  x)
	{
		return Compare(*this, x) < 0;
	}

	Bool operator >= (ref const LocalFileTime  x)
	{
		return Compare(*this, x) >= 0;
	}

	Bool operator <= (ref const LocalFileTime  x)
	{
		return Compare(*this, x) <= 0;
	}
*/
};

enum GE_FILETIME_CREATED =	 0;
enum GE_FILETIME_MODIFIED = 1;
enum GE_FILETIME_ACCESS =	 2;

enum BROWSEFILES_CALCSIZE =				(1 << 0);
enum BROWSEFILES_SUPPRESSCACHING =	(1 << 1);
