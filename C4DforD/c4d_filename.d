
module c4d_filename;

import c4d;
import c4d_os;

import c4d_string;

//=============================================================================
struct MemoryFileStruct
{
private:
	@disable static MemoryFileStruct opCall();
	@disable ~this(){}

public:
	//static MemoryFileStruct* Alloc(){ return C4DOS.Fn.MemoryFileStructAlloc(); }
	//static void Free(ref MemoryFileStruct*  mfs) { C4DOS.Fn.MemoryFileStructFree(mfs); }

	//void GetData(ref void* data, ref Int  size, Bool release = false){ C4DOS.Fn.MemoryFileStructGetData(this, data, size, release); }
};

//#define FnCall(fnc) (this->*C4DOS.Fn->fnc)
//#define FlCall(fnc) (this->*C4DOS.Fl->fnc)
//#define HfCall(fnc) (this->*C4DOS.Hf->fnc)


//=============================================================================
struct Filename
{
//private:
public:
	String	 dummy1;
	void*	 dummy2=null;
	Int		 dummy3=0;
	Int32	 dummy4=0;

public:

	//? @disable this();
	//this() { C4DOS.Fn->Init(&this); }

	//@disable this(this);
	this(this) {
		Filename tmp;
		MemCopy(&tmp,&this,Filename.sizeof);
		tmp.dummy1 = dummy1; //???

		C4DOS.Fn.Init(&this); //important 
		C4DOS.Fn.CopyTo(&tmp, &this);

		//tmp.dummy1 = 0;//???
		tmp.dummy2 = null;
		tmp.dummy3 = 0;
		tmp.dummy3 = 0;
	}

	this(const Char* str) { 	C4DOS.Fn.Init(&this); C4DOS.Fn.SetCString(&this, str); }

	this(ref const String  str){ C4DOS.Fn.Init(&this); C4DOS.Fn.SetString(&this, &str); }
	this(in String str){ C4DOS.Fn.Init(&this); C4DOS.Fn.SetString(&this, &str); }

	this(ref const Filename  src){ 	C4DOS.Fn.Init(&this); C4DOS.Fn.CopyTo(&src, &this); }
	this(in Filename  src){ 	C4DOS.Fn.Init(&this); C4DOS.Fn.CopyTo(&src, &this); }

	~this(){ C4DOS.Fn.Flush(&this); }

	void CopyTo(Filename* dst) const { C4DOS.Fn.CopyTo(&this, dst); }

	Bool FileSelect(FILESELECTTYPE type, FILESELECT flags, ref const String  title, ref const String force_suffix /*= String()*/ )
	{	return C4DOS.Fn.FileSelect(&this, type, flags, title, force_suffix); }

	Bool Content() const { return C4DOS.Fn.Content(&this); }

	String GetString() const { return C4DOS.Fn.GetString(&this); }
	void SetString(ref const String  str) { C4DOS.Fn.SetString(&this, &str); }

	Filename GetDirectory() const { return C4DOS.Fn.GetDirectory(&this); }
	Filename GetFile() const { return C4DOS.Fn.GetFile(&this); }
	String GetFileString() const { return GetFile().GetString(); }

	void ClearSuffix() { C4DOS.Fn.ClearSuffix(&this); }
	void ClearSuffixComplete() { C4DOS.Fn.ClearSuffixComplete(&this); }
	void SetSuffix(ref const String  str) { C4DOS.Fn.SetSuffix(&this, &str); }
	Bool CheckSuffix(ref const String  str) const { return C4DOS.Fn.CheckSuffix(&this, &str); }

	void SetDirectory(ref const Filename  str) { C4DOS.Fn.SetDirectory(&this, &str); }
	void SetFile(ref const Filename  str) { C4DOS.Fn.SetFile(&this, &str); }

	void SetMemoryReadMode(void * adr, Int size = -1) {  C4DOS.Fn.SetMemoryReadMode(&this, adr, size); }
	//? void SetMemoryWriteMode(MemoryFileStruct* mfs) { C4DOS.Fn.SetMemoryWriteMode(&this, mfs); }

	//void SetIpConnection(NetworkIpConnection* ipc);
	//NetworkIpConnection* GetIpConnection() const;

	// operator +, ~
	const Filename opBinary(string op)(auto ref const Filename rhs) {
		static if (op == "~") { //~
			Filename fn = Filename(this);
			C4DOS.Fn.Add(&fn, &rhs);
			return fn;
		} else
		static if (op == "+") { //+
			Filename fn = Filename(this);
			C4DOS.Fn.Add(&fn, &rhs);
			return fn;
		}
		else static assert(0, "Operator "~op~" not implemented");
	}

	// operator +=, ~=
	ref const(Filename) opOpAssign(string op) (auto ref const Filename rhs) {
		static if (op == "~") { //~=
			C4DOS.Fn.Add(this, &rhs);
			return this;
		} 
		else static if (op == "+") { //+=
			C4DOS.Fn.Add(this, &rhs);
			return this;
		}
		else static assert(0, "Operator "~op~" not implemented");
	}

	bool opEquals(ref const Filename rhs) const {
		return cast(bool)C4DOS.Fn.Compare(&this, &rhs);
	}
	bool opEquals(in Filename rhs) const {
		return cast(bool)C4DOS.Fn.Compare(&this, &rhs);
	}

	/*
	const Filename&	operator =  (const Filename& fname);
	friend const Filename	operator +  (const Filename& fname1, const Filename& fname2);
	const Filename&	operator += (const Filename& fname);
	Bool operator == (const Filename& fname) const;
	Bool operator != (const Filename& fname) const
	*/

	String GetSuffix() const { return C4DOS.Fn.GetSuffix(&this); }
	//?  Bool IsBrowserUrl() const { return C4DOS.Fn.IsBrowserUrl(&this); }
};


static assert(Filename.sizeof==48,"sizeof Filename is not 48 bytes !");

unittest
{
if(C4DOS) {

	Filename fn;
	assert(fn.Content() == false);

	const String st = "test";
	fn.SetString(st);
	{
		Filename copy = fn;
		assert(fn==copy);
	}
	assert(fn.GetString()==st);

}//if(C4DOS)
}

/+

class Filename
{
	Filename(void);
	Filename(const Char* string);
	Filename(const String& string);
	Filename(const Filename& src);
	~Filename(void);

	void CopyTo(Filename* dst) const;

	Bool FileSelect(FILESELECTTYPE type, FILESELECT flags, const String& title, const String& force_suffix = String());

	Bool Content(void) const;

	String GetString(void) const;
	void SetString(const String& str);

	const Filename GetDirectory(void) const;
	const Filename GetFile(void) const;
	String GetFileString(void) const;

	void ClearSuffix(void);
	void ClearSuffixComplete(void);
	void SetSuffix(const String& str);
	Bool CheckSuffix(const String& str) const;

	void SetDirectory(const Filename& str);
	void SetFile(const Filename& str);

	void SetMemoryReadMode(void* adr, Int size = -1);
	void SetMemoryWriteMode(MemoryFileStruct* mfs);

	void SetIpConnection(NetworkIpConnection* ipc);
	NetworkIpConnection* GetIpConnection() const;

	const Filename&	operator =  (const Filename& fname);
	friend const Filename	operator +  (const Filename& fname1, const Filename& fname2);
	const Filename&	operator += (const Filename& fname);
	Bool operator == (const Filename& fname) const;
	Bool operator != (const Filename& fname) const;

	String GetSuffix(void) const;
	Bool IsBrowserUrl() const;
};


typedef Filename RelativeFilename;

class BaseFile
{
	private:
	BaseFile();
	~BaseFile();

	public:
	// Open a file, name is of type filename
	// mode					: read, write or readwrite
	// error_dialog	: display any errors in dialogs
	// order				:	little or big endian
	// type,creator	: MAC file types
	Bool Open(const Filename& name, FILEOPEN mode = FILEOPEN_READ, FILEDIALOG error_dialog = FILEDIALOG_IGNOREOPEN, BYTEORDER order = BYTEORDER_MOTOROLA, Int32 type = MACTYPE_CINEMA, Int32 creator = MACCREATOR_CINEMA);

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
	Bool WriteFilename(const Filename& v);
	Bool WriteBool(Bool v);
	Bool WriteString(const String& v);
	Bool WriteVector32(const Vector32& v);
	Bool WriteVector64(const Vector64& v);
	Bool WriteMatrix32(const Matrix32& v);
	Bool WriteMatrix64(const Matrix64& v);

	static BaseFile* Alloc(void);
	static void Free(BaseFile*& fl);
};

class AESFile : public BaseFile
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
	Bool Open(const Filename& name, const char* key, Int32 keylen, Int32 blocksize, UInt32 aes_flags, FILEOPEN mode = FILEOPEN_READ, FILEDIALOG error_dialog = FILEDIALOG_IGNOREOPEN, BYTEORDER order = BYTEORDER_MOTOROLA, Int32 type = MACTYPE_CINEMA, Int32 creator = MACCREATOR_CINEMA);

	// checks if encrypt is the encrypted version of decrypt
	static Bool CheckEncryption(const Filename& encrypt, const Filename& decrypt, const char* key, Int32 keylen, Int32 blocksize);

	static AESFile* Alloc(void);
	static void Free(AESFile*& fl);
};

class LocalFileTime
{
public:
	UInt16 year;
	UInt16 month;
	UInt16 day;
	UInt16 hour;
	UInt16 minute;
	UInt16 second;

	void Init(void)
	{
	year = month = day = hour = minute = second = 0;
	}

	// > 0: t0 > t1
	// = 0: t0 == t1
	// < 0: t0 < t1
	Int32	Compare(const LocalFileTime& t0, const LocalFileTime& t1)
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

	Bool operator == (const LocalFileTime& x)
	{
	return year == x.year && month == x.month && day == x.day && hour == x.hour && minute == x.minute && second == x.second;
	}

	Bool operator != (const LocalFileTime& x)
	{
	return year != x.year || month != x.month || day != x.day || hour != x.hour || minute != x.minute || second != x.second;
	}

	Bool operator > (const LocalFileTime& x)
	{
	return Compare(*this, x) > 0;
	}

	Bool operator < (const LocalFileTime& x)
	{
	return Compare(*this, x) < 0;
	}

	Bool operator >= (const LocalFileTime& x)
	{
	return Compare(*this, x) >= 0;
	}

	Bool operator <= (const LocalFileTime& x)
	{
	return Compare(*this, x) <= 0;
	}
};

#define	GE_FILETIME_CREATED	 0
#define	GE_FILETIME_MODIFIED 1
#define	GE_FILETIME_ACCESS	 2

#define BROWSEFILES_CALCSIZE				(1 << 0)
#define BROWSEFILES_SUPPRESSCACHING	(1 << 1)

class BrowseFiles
{
private:
BrowseFiles();
~BrowseFiles();

public:
void Init(const Filename& directory, Int32 flags);
Bool GetNext(void);

Int64 GetSize(void);
Bool IsDir(void);
Bool IsHidden(void);
Bool IsBundle(void);
Bool IsReadOnly(void);

void GetFileTime(Int32 mode, LocalFileTime* out);

Filename GetFilename(void);

static BrowseFiles* Alloc();
static void Free(BrowseFiles*& bf);
};

#define BROWSEVOLUMES_VOLUME_NOT_AVAILABLE (1 << 7)

class BrowseVolumes
{
private:
BrowseVolumes();
~BrowseVolumes();

public:
void Init(void);
Bool GetNext(void);
Filename GetFilename(void);
String GetVolumeName(Int32* out_flags);

static BrowseVolumes* Alloc();
static void Free(BrowseVolumes*& bf);
};

typedef Int32 (*FileMonitorCallback)(const Filename& item, Int flags, void* userdata);

class FileMonitor
{
public:
static Bool	WatchFolder(const Filename& folder, FileMonitorCallback callback, void* userdata);
static Bool	DontWatchFolder(const Filename& folder, FileMonitorCallback callback, void* userdata);
static Bool	WatchFile(const Filename& file, FileMonitorCallback callback, void* userdata);
static Bool	DontWatchFile(const Filename& file, FileMonitorCallback callback, void* userdata);
};

class HyperFile
{
private:
HyperFile();
~HyperFile();

public:
Bool WriteChar(Char v);
Bool WriteUChar(UChar v);
Bool WriteInt16(Int16 v);
Bool WriteUInt16(UInt16 v);
Bool WriteInt32(Int32 v);
Bool WriteUInt32(UInt32 v);
Bool WriteInt64(Int64 v);
Bool WriteUInt64(UInt64 v);
Bool WriteFloat(Float v);
Bool WriteFloat32(Float32 v);
Bool WriteFloat64(Float64 v);
Bool WriteBool(Bool v);
Bool WriteTime(const BaseTime& v);
Bool WriteVector(const Vector& v);
Bool WriteVector32(const Vector32& v);
Bool WriteVector64(const Vector64& v);
Bool WriteMatrix(const Matrix& v);
Bool WriteMatrix32(const Matrix32& v);
Bool WriteMatrix64(const Matrix64& v);
Bool WriteString(const String& v);
Bool WriteFilename(const Filename& v);
Bool WriteImage(BaseBitmap* v, Int32 format, BaseContainer* data, SAVEBIT savebits = SAVEBIT_ALPHA);
Bool WriteGeData(const GeData& v);
Bool WriteContainer(const BaseContainer& v);
Bool WriteMemory(const void* data, Int count);
Bool WriteChannel(BaseChannel* bc);
Bool WriteArray(const void* data, HYPERFILEARRAY datatype, Int32 structure_increment, Int32 count);
Bool WriteUuid(const C4DUuid& v);

Bool ReadChar(Char* v);
Bool ReadUChar(UChar* v);
Bool ReadInt16(Int16* v);
Bool ReadUInt16(UInt16* v);
Bool ReadInt32(Int32* v);
Bool ReadUInt32(UInt32* v);
Bool ReadInt64(Int64* v);
Bool ReadUInt64(UInt64* v);
Bool ReadFloat(Float* v);
Bool ReadFloat32(Float32* v);
Bool ReadFloat64(Float64* v);
Bool ReadBool(Bool* v);
Bool ReadTime(BaseTime* v);
Bool ReadVector(Vector* v);
Bool ReadVector32(Vector32* v);
Bool ReadVector64(Vector64* v);
Bool ReadMatrix(Matrix* v);
Bool ReadMatrix32(Matrix32* v);
Bool ReadMatrix64(Matrix64* v);
Bool ReadString(String* v);
Bool ReadFilename(Filename* v);
Bool ReadImage(BaseBitmap* v);
Bool ReadGeData(GeData* v);
Bool ReadContainer(BaseContainer* v, Bool flush);
Bool ReadMemory(void** data, Int* size);
Bool ReadChannel(BaseChannel* bc);
Bool ReadChannelConvert(GeListNode* node, Int32 link_id);
Bool ReadArray(void* data, HYPERFILEARRAY type, Int32 structure_increment, Int32 count);
Bool ReadUuid(C4DUuid* v);

FILEERROR GetError() const;
void SetError(FILEERROR err);
Bool ReadValueHeader(HYPERFILEVALUE* h);
Bool SkipValue(HYPERFILEVALUE h);
Bool WriteChunkStart(Int32 id, Int32 level);
Bool WriteChunkEnd(void);
Bool ReadChunkStart(Int32* id, Int32* level);
Bool ReadChunkEnd(void);
Bool SkipToEndChunk(void);

LOCATION GetLocation(void) const;

Int32 GetFileVersion() const;
void SetFileVersion(Int32 val);

BaseDocument* GetDocument() const;

static HyperFile* Alloc(void);
static void Free(HyperFile*& fl);
Bool Open(Int32 ident, const Filename& filename, FILEOPEN mode, FILEDIALOG error_dialog);
Bool Close();
};

FILEERROR ReadHyperFile(BaseDocument* doc, GeListNode* node, const Filename& filename, Int32 ident, String* warning_string);
FILEERROR WriteHyperFile(BaseDocument* doc, GeListNode* node, const Filename& filename, Int32 ident);

// file IO
#define	GE_FKILL_DIRECTORY 1
#define	GE_FKILL_RECURSIVE 2
#define	GE_FKILL_FORCE		 4

#define GE_FCOPY_OVERWRITE				1
#define GE_FCOPY_DONTCOPYREADONLY	2

#define GE_FILE_ATTRIBUTE_READONLY	0x00000001
#define GE_FILE_ATTRIBUTE_HIDDEN		0x00000002
#define GE_FILE_ATTRIBUTE_LOCKED		0x00000010	// only for Mac, ignored on Windows
#define GE_FILE_ATTRIBUTE_OWNER_R		0x00000100	// unix attributes
#define GE_FILE_ATTRIBUTE_OWNER_W		0x00000200
#define GE_FILE_ATTRIBUTE_OWNER_X		0x00000400
#define GE_FILE_ATTRIBUTE_GROUP_R		0x00000800
#define GE_FILE_ATTRIBUTE_GROUP_W		0x00001000
#define GE_FILE_ATTRIBUTE_GROUP_X		0x00002000
#define GE_FILE_ATTRIBUTE_PUBLIC_R	0x00004000
#define GE_FILE_ATTRIBUTE_PUBLIC_W	0x00008000
#define GE_FILE_ATTRIBUTE_PUBLIC_X	0x00010000
#define GE_FILE_ATTRIBUTS_UNIX_MASK	0x0001ff00

Bool GeFExist    (const Filename& name, Bool isdir = false);
Bool GeSearchFile(const Filename& directory, const Filename& name, Filename* found);
Bool GeFKill     (const Filename& name, Int32 flags = 0);
Bool GeFCopyFile (const Filename& source, const Filename& dest, Int32 flags);
Bool GeFRename   (const Filename& source, const Filename& dest);
Bool GeFMove     (const Filename& source, const Filename& dest);
Bool GeFCreateDir(const Filename& name);
Bool GeFCreateDirRec(const Filename& name);
Bool GeExecuteFile(const Filename& path);
Bool GeExecuteProgram(const Filename& program, const Filename& file);
typedef Int32 (*GeExecuteProgramExCallback)(Int32 cmd, void* userdata, const Filename& logfile);
// callback return values:
// return 0 to continue
// return 'stop' to kill the running process
Bool GeExecuteProgramEx(const Filename& program, const String* args, Int32 argcnt, GeExecuteProgramExCallback callback, void* userdata);
Bool GeFGetDiskFreeSpace(const Filename& vol, UInt64& freecaller, UInt64& total, UInt64& freespace);
UInt32 GeFGetAttributes(const Filename& name);
Bool GeFSetAttributes(const Filename& name, UInt32 flags, UInt32 mask = (UInt32) - 1);
const Filename GeGetStartupPath(void);
const Filename GeGetStartupApplication(void);
const Filename GeGetStartupWritePath(void);
const Filename GeGetPluginPath(void);
Filename GeGetPluginResourcePath();

#define C4D_PATH_PREFS				1		// c4d prefs directory
#define C4D_PATH_RESOURCE			2		// c4d resource directory
#define C4D_PATH_LIBRARY			3		// c4d library (built-in)
#define C4D_PATH_LIBRARY_USER	4		// c4d library (different if multiuser mode enabled)
#define C4D_PATH_ONLINE_HELP	5		// c4d online help directory
#define C4D_PATH_DESKTOP			6		// OS desktop directory
#define C4D_PATH_HOME					7		// OS home directory
#define C4D_PATH_STARTUPWRITE	8		// Writeable StartupDir!
#define C4D_PATH_MYDOCUMENTS	9		// my documents path!
#define C4D_PATH_APPLICATION	10	// OS Application Directory

const Filename GeGetC4DPath(Int32 whichpath);

Bool GeGetFileTime(const Filename& name, Int32 mode, LocalFileTime* out);
Bool GeSetFileTime(const Filename& name, Int32 mode, const LocalFileTime* in);
void GeGetCurrentTime(LocalFileTime* out);

String DateToString(const LocalFileTime& t, Bool date_only);
Bool ShowInFinder(const Filename& fn, Bool open);

Bool RequestFileFromServer(const Filename& fn, Filename& res);

namespace maxon
{
class String;
class Url;
class FormatStatement;
}

maxon::String ToString(const Filename& val, const maxon::FormatStatement* formatStatement, maxon::Bool checkDatatype = false);
maxon::Url MaxonConvert(const Filename& fn);
Filename MaxonConvert(const maxon::Url & fn);

#endif

#endif // C4D_FILE_H__


+/

