/////////////////////////////////////////////////////////////
// CINEMA 4D SDK                                           //
/////////////////////////////////////////////////////////////
// (c) MAXON Computer GmbH, all rights reserved            //
// Ported from C++ by Remotion (remotion4d.net)			   //
// based on ge_matrix.h and ge_lmatrix.h				   //
/////////////////////////////////////////////////////////////
module c4d_matrix;

import c4d;
import c4d_os;

public import c4d_vector;

import std.traits : isNumeric;


alias MatrixT!(Float)		Matrix;  
alias MatrixT!(Float32)		Matrix32;
alias MatrixT!(Float64)		Matrix64;

static assert(Matrix32.sizeof == 4*3 * float.sizeof);
static assert(Matrix64.sizeof == 4*3 * double.sizeof);

//=============================================================================
/// Generic 3d matrix
/// params: 
///    T = type of elements
//=============================================================================
struct MatrixT(T)  if (isNumeric!T) 
{
@nogc:
@safe:
pure:
nothrow:

	alias VecT = VectorT!T;

public:  /// data
	VecT	off = VecT(0.0, 0.0, 0.0);
	VecT	v1  = VecT(1.0, 0.0, 0.0);
	VecT	v2  = VecT(0.0, 1.0, 0.0);
	VecT	v3  = VecT(0.0, 0.0, 1.0);

public:
	/// CTor's
	this(_DONTCONSTRUCT dc) pure nothrow { /*off = void; v1 = void; v2 = void; v3 = void;*/ } //does this work ?

	this(_INITTCONSTRUCT ic) pure nothrow {
		off = VecT(0.0, 0.0, 0.0);
		v1	= VecT(1.0, 0.0, 0.0);
		v2	= VecT(0.0, 1.0, 0.0);
		v3	= VecT(0.0, 0.0, 1.0);
	}

	this(T0 : VecT, T1 : VecT, T2 : VecT, T3 : VecT)
		(in T0 off_in,in T1 v1_in,in T2 v2_in,in T3 v3_in)  pure nothrow  {
		off = off_in;
		v1	= v1_in;
		v2	= v2_in;
		v3	= v3_in;
	}


	/// methods
	void Normalize() {
		v1.Normalize();
		v2.Normalize();
		v3.Normalize();
	}

	MatrixT GetTensorMatrix() const {
		return MatrixT( VecT(0.0), 
						VecT(v3.z * v2.y - v3.y * v2.z, v3.x * v2.z - v3.z * v2.x, v3.y * v2.x - v3.x * v2.y), 
						VecT(v3.y * v1.z - v1.y * v3.z, v3.z * v1.x - v3.x * v1.z, v1.y * v3.x - v3.y * v1.x), 
						VecT(v1.y * v2.z - v1.z * v2.y, v1.z * v2.x - v1.x * v2.z, v1.x * v2.y - v1.y * v2.x));
	}

	void Scale(ref const VecT v) {
		v1 *= v.x;
		v2 *= v.y;
		v3 *= v.z;
	}

	void Scale(T r)	{
		v1 *= r;
		v2 *= r;
		v3 *= r;
	}

	VecT Scale() const { return VecT(Len(v1), Len(v2), Len(v3)); }

	VecT TransformVector(ref const VecT v) const {
		return VecT(v1.x * v.x + v2.x * v.y + v3.x * v.z, v1.y * v.x + v2.y * v.y + v3.y * v.z, v1.z * v.x + v2.z * v.y + v3.z * v.z);
	}

	/// operators 

	/// operator []
	ref VecT opIndex(size_t i) @system {
		return (&off)[i & 3]; //not @safe
		//return v[i];
	}
	ref const(VecT) opIndex(size_t i) const @system	{
		return (&off)[i & 3];  //not @safe
		//return v[i];
	}

	/// operator ==,  operator !=
	bool opEquals(M)(auto ref const M m2) const  {
		return (off == m2.off) && (v1 == m2.v1) && (v2 == m2.v2) && (v3 == m2.v3);
	}

	/// operator *
	/// Multiplies two matrices.
	/// The rule is m1 AFTER m2
	/// If you transform a point with the result matrix this is identical to first transforming with m2 and then with m1
	auto opBinary(string op, U)(U m2) const
		if(op == "*")
	{
		return MatrixT(off + v1 * m2.off.x + v2 * m2.off.y + v3 * m2.off.z,
						v1 * m2.v1.x + v2 * m2.v1.y + v3 * m2.v1.z,
						v1 * m2.v2.x + v2 * m2.v2.y + v3 * m2.v2.z,
						v1 * m2.v3.x + v2 * m2.v3.y + v3 * m2.v3.z);
	}

	/// operator *
	/// Transforms a point by a matrix
	auto opBinary(string op, U : VecT)(U v) const
		if(op == "*")
	{
		return VecT(off.x + v1.x * v.x + v2.x * v.y + v3.x * v.z,
					off.y + v1.y * v.x + v2.y * v.y + v3.y * v.z,
					off.z + v1.z * v.x + v2.z * v.y + v3.z * v.z);
	}

	///operator +, operator -
	// m1 + m2;
	auto opBinary(string op, M)(in M m2) {
		static if(op=="+"||op=="-"){
			mixin( "return MatrixT(m1.off "~op~" m2.off, m1.v1 "~op~" m2.v1, m1.v2 "~op~" m2.v2, m1.v3 "~op~" m2.v3);" );
		} else 
		/// Multiplies two matrices.
		/// The rule is m1 AFTER m2
		/// If you transform a point with the result matrix this is identical to first transforming with m2 and then with m1
		static if(op=="*"){
			return MatrixT(off + v1 * m2.off.x + v2 * m2.off.y + v3 * m2.off.z,
							v1 * m2.v1.x + v2 * m2.v1.y + v3 * m2.v1.z,
							v1 * m2.v2.x + v2 * m2.v2.y + v3 * m2.v2.z,
							v1 * m2.v3.x + v2 * m2.v3.y + v3 * m2.v3.z);
		}
		else static assert(0, "MatrixT Operator "~op~" not implemented");
	}


	//const Matrix32 operator ~ (const Matrix32& m)
	MatrixT Invert() const {
		MatrixT m = this;
		MatrixT mi = void;
		T det = (m.v1.x * (m.v2.y * m.v3.z - m.v3.y * m.v2.z) +
					   m.v2.x * (m.v3.y * m.v1.z - m.v1.y * m.v3.z) +
					   m.v3.x * (m.v1.y * m.v2.z - m.v2.y * m.v1.z));

		if (det == 0.0)
			return MatrixT();

		det = 1.0 / det;
		mi.off.x = (m.v2.x * (m.off.y * m.v3.z - m.v3.y * m.off.z) +
					m.v3.x * (m.off.z * m.v2.y - m.off.y * m.v2.z) +
					m.off.x * (m.v3.y * m.v2.z - m.v2.y * m.v3.z)) * det;
		mi.off.y = (m.v3.x * (m.off.y * m.v1.z - m.v1.y * m.off.z) +
					m.off.x * (m.v1.y * m.v3.z - m.v3.y * m.v1.z) +
					m.v1.x * (m.v3.y * m.off.z - m.off.y * m.v3.z)) * det;
		mi.off.z = (m.off.x * (m.v2.y * m.v1.z - m.v1.y * m.v2.z) +
					m.v1.x * (m.v2.z * m.off.y - m.v2.y * m.off.z) +
					m.v2.x * (m.off.z * m.v1.y - m.off.y * m.v1.z)) * det;

		mi.v1.x = (m.v2.y * m.v3.z - m.v3.y * m.v2.z) * det;
		mi.v1.y = (m.v3.y * m.v1.z - m.v1.y * m.v3.z) * det;
		mi.v1.z = (m.v1.y * m.v2.z - m.v2.y * m.v1.z) * det;

		mi.v2.x = (m.v2.z * m.v3.x - m.v3.z * m.v2.x) * det;
		mi.v2.y = (m.v3.z * m.v1.x - m.v1.z * m.v3.x) * det;
		mi.v2.z = (m.v1.z * m.v2.x - m.v2.z * m.v1.x) * det;

		mi.v3.x = (m.v2.x * m.v3.y - m.v3.x * m.v2.y) * det;
		mi.v3.y = (m.v3.x * m.v1.y - m.v1.x * m.v3.y) * det;
		mi.v3.z = (m.v1.x * m.v2.y - m.v2.x * m.v1.y) * det;

		return mi;
	}
};

MatrixT!T Invert(T)(auto ref const MatrixT!T m) 
{
	MatrixT!T mi = void;
	T det = (m.v1.x * (m.v2.y * m.v3.z - m.v3.y * m.v2.z) +
			 m.v2.x * (m.v3.y * m.v1.z - m.v1.y * m.v3.z) +
			 m.v3.x * (m.v1.y * m.v2.z - m.v2.y * m.v1.z));

	if (det == 0.0)
		return MatrixT!T();

	det = 1.0 / det;
	mi.off.x = (m.v2.x * (m.off.y * m.v3.z - m.v3.y * m.off.z) +
				m.v3.x * (m.off.z * m.v2.y - m.off.y * m.v2.z) +
				m.off.x * (m.v3.y * m.v2.z - m.v2.y * m.v3.z)) * det;
	mi.off.y = (m.v3.x * (m.off.y * m.v1.z - m.v1.y * m.off.z) +
				m.off.x * (m.v1.y * m.v3.z - m.v3.y * m.v1.z) +
				m.v1.x * (m.v3.y * m.off.z - m.off.y * m.v3.z)) * det;
	mi.off.z = (m.off.x * (m.v2.y * m.v1.z - m.v1.y * m.v2.z) +
				m.v1.x * (m.v2.z * m.off.y - m.v2.y * m.off.z) +
				m.v2.x * (m.off.z * m.v1.y - m.off.y * m.v1.z)) * det;

	mi.v1.x = (m.v2.y * m.v3.z - m.v3.y * m.v2.z) * det;
	mi.v1.y = (m.v3.y * m.v1.z - m.v1.y * m.v3.z) * det;
	mi.v1.z = (m.v1.y * m.v2.z - m.v2.y * m.v1.z) * det;

	mi.v2.x = (m.v2.z * m.v3.x - m.v3.z * m.v2.x) * det;
	mi.v2.y = (m.v3.z * m.v1.x - m.v1.z * m.v3.x) * det;
	mi.v2.z = (m.v1.z * m.v2.x - m.v2.z * m.v1.x) * det;

	mi.v3.x = (m.v2.x * m.v3.y - m.v3.x * m.v2.y) * det;
	mi.v3.y = (m.v3.x * m.v1.y - m.v1.x * m.v3.y) * det;
	mi.v3.z = (m.v1.x * m.v2.y - m.v2.x * m.v1.y) * det;

	return mi;
}

/// unittest >>>
static assert(Matrix.sizeof==96,"sizeof Matrix is not 96 bytes !");
static assert(Matrix64.sizeof==96,"sizeof Matrix64 is not 96 bytes !");
static assert(Matrix32.sizeof==48,"sizeof Matrix32 is not 48 bytes !");

/// operator ==,  operator !=
static assert(Matrix(Vector(0.1,0.2,0.3),
					 Vector(1.0,2.0,3.0),
					 Vector(4.0,5.0,6.0),
					 Vector(7.0,8.0,9.0)) == Matrix(Vector(0.1,0.2,0.3),
													Vector(1.0,2.0,3.0),
													Vector(4.0,5.0,6.0),
													Vector(7.0,8.0,9.0)));

static assert(Matrix(Vector(8.1,0.2,0.3),
					 Vector(1.0,2.0,3.0),
					 Vector(4.0,5.0,6.0),
					 Vector(7.0,8.0,9.0)) != Matrix(Vector(0.1,0.2,0.3),
													Vector(1.0,2.0,3.0),
													Vector(4.0,5.0,6.0),
													Vector(7.0,8.0,9.0)));

/+
struct Matrix32
{
	Vector32 off, v1, v2, v3;

	Matrix32()
	{
		off = Vector32(0.0f, 0.0f, 0.0f);
		v1	= Vector32(1.0f, 0.0f, 0.0f);
		v2	= Vector32(0.0f, 1.0f, 0.0f);
		v3	= Vector32(0.0f, 0.0f, 1.0f);
	}
	explicit Matrix32(const Vector32& off_in, const Vector32& v1_in, const Vector32& v2_in, const Vector32& v3_in)
	{
		off = off_in;
		v1	= v1_in;
		v2	= v2_in;
		v3	= v3_in;
	}
	explicit Matrix32(_DONTCONSTRUCT v) : off(v), v1(v), v2(v), v3(v) { }
	explicit Matrix32(const Matrix64& v);

#ifdef __LEGACY_API
	friend const Matrix32 operator ! (const Matrix32& m) { return ~m; }
	Vector32 Mul(const Vector32& v) const { return Vector32(off.x + v1.x * v.x + v2.x * v.y + v3.x * v.z, off.y + v1.y * v.x + v2.y * v.y + v3.y * v.z, off.z + v1.z * v.x + v2.z * v.y + v3.z * v.z); }
	Vector64 Mul(const Vector64& v) const { return Vector64(off.x + v1.x * v.x + v2.x * v.y + v3.x * v.z, off.y + v1.y * v.x + v2.y * v.y + v3.y * v.z, off.z + v1.z * v.x + v2.z * v.y + v3.z * v.z); }
	Vector32 MulV(const Vector32& v) const { return Vector32(v1.x * v.x + v2.x * v.y + v3.x * v.z, v1.y * v.x + v2.y * v.y + v3.y * v.z, v1.z * v.x + v2.z * v.y + v3.z * v.z); }
	Vector64 MulV(const Vector64& v) const { Float32 x = (Float32) v.x, y = (Float32) v.y, z = (Float32) v.z; return Vector64(Float64(v1.x * x + v2.x * y + v3.x * z), Float64(v1.y * x + v2.y * y + v3.y * z), Float64(v1.z * x + v2.z * y + v3.z * z)); }
	friend const Vector32 operator ^ (const Vector32& v, const Matrix32& m) { return Vector32(m.v1.x * v.x + m.v2.x * v.y + m.v3.x * v.z, m.v1.y * v.x + m.v2.y * v.y + m.v3.y * v.z, m.v1.z * v.x + m.v2.z * v.y + m.v3.z * v.z); }
	friend const Vector32 operator * (const Vector32& v, const Matrix32& m) { return Vector32(m.off.x + m.v1.x * v.x + m.v2.x * v.y + m.v3.x * v.z, m.off.y + m.v1.y * v.x + m.v2.y * v.y + m.v3.y * v.z, m.off.z + m.v1.z * v.x + m.v2.z * v.y + m.v3.z * v.z); }
	inline const Matrix64 ToLM() const;
	inline const Matrix32& ToSM() const { return *this; }
	inline const Matrix64 ToRM() const;
#endif

	/// Multiplies two matrices.
	/// The rule is m1 AFTER m2
	/// If you transform a point with the result matrix this is identical to first transforming with m2 and then with m1
	Matrix32 operator *(const Matrix32& m2) const
	{
		return Matrix32(off + v1 * m2.off.x + v2 * m2.off.y + v3 * m2.off.z,
						 v1 * m2.v1.x + v2 * m2.v1.y + v3 * m2.v1.z,
						 v1 * m2.v2.x + v2 * m2.v2.y + v3 * m2.v2.z,
						 v1 * m2.v3.x + v2 * m2.v3.y + v3 * m2.v3.z);
	}

	/// Transforms a point by a matrix
	Vector32 operator *(const Vector32& v) const
	{
		return Vector32(off.x + v1.x * v.x + v2.x * v.y + v3.x * v.z,
						 off.y + v1.y * v.x + v2.y * v.y + v3.y * v.z,
						 off.z + v1.z * v.x + v2.z * v.y + v3.z * v.z);
	}

	/// Scales all matrix components by a scalar value
	friend Matrix32 operator *(Float32 s, const Matrix32& m)
	{
		return Matrix32(s * m.off, s * m.v1, s * m.v2, s * m.v3);
	}

	/// Scales all matrix components by a scalar value
	Matrix32 operator *(Float32 s) const
	{
		return Matrix32(off * s, v1 * s, v2 * s, v3 * s);
	}

	Vector32 TransformVector(const Vector32& v) const
	{
		return Vector32(v1.x * v.x + v2.x * v.y + v3.x * v.z, v1.y * v.x + v2.y * v.y + v3.y * v.z, v1.z * v.x + v2.z * v.y + v3.z * v.z);
	}

	friend const Matrix32 operator / (const Matrix32& m, const Float32 s)
	{
		return Matrix32(m.off / s, m.v1 / s, m.v2 / s, m.v3 / s);
	}

	friend const Matrix32 operator + (const Matrix32& m1, const Matrix32& m2)
	{
		return Matrix32(m1.off + m2.off, m1.v1 + m2.v1, m1.v2 + m2.v2, m1.v3 + m2.v3);
	}

	friend const Matrix32 operator - (const Matrix32& m1, const Matrix32& m2)
	{
		return Matrix32(m1.off - m2.off, m1.v1 - m2.v1, m1.v2 - m2.v2, m1.v3 - m2.v3);
	}

	friend Bool operator == (const Matrix32& m1, const Matrix32& m2)
	{
		return (m1.off == m2.off) && (m1.v1 == m2.v1) && (m1.v2 == m2.v2) && (m1.v3 == m2.v3);
	}

	friend Bool operator != (const Matrix32& m1, const Matrix32& m2)
	{
		return !(m1 == m2);
	}

	friend const Matrix32 operator ~ (const Matrix32& m)
	{
		Matrix32 mi(DC);

		Float32 det = (m.v1.x * (m.v2.y * m.v3.z - m.v3.y * m.v2.z) +
									 m.v2.x * (m.v3.y * m.v1.z - m.v1.y * m.v3.z) +
								  	 m.v3.x * (m.v1.y * m.v2.z - m.v2.y * m.v1.z));

		if (det == 0.0f)
			return Matrix32();

		det = 1.0f / det;
		mi.off.x = (m.v2.x * (m.off.y * m.v3.z - m.v3.y * m.off.z) +
								m.v3.x * (m.off.z * m.v2.y - m.off.y * m.v2.z) +
								m.off.x * (m.v3.y * m.v2.z - m.v2.y * m.v3.z)) * det;
		mi.off.y = (m.v3.x * (m.off.y * m.v1.z - m.v1.y * m.off.z) +
								m.off.x * (m.v1.y * m.v3.z - m.v3.y * m.v1.z) +
								m.v1.x * (m.v3.y * m.off.z - m.off.y * m.v3.z)) * det;
		mi.off.z = (m.off.x * (m.v2.y * m.v1.z - m.v1.y * m.v2.z) +
								m.v1.x * (m.v2.z * m.off.y - m.v2.y * m.off.z) +
								m.v2.x * (m.off.z * m.v1.y - m.off.y * m.v1.z)) * det;

		mi.v1.x = (m.v2.y * m.v3.z - m.v3.y * m.v2.z) * det;
		mi.v1.y = (m.v3.y * m.v1.z - m.v1.y * m.v3.z) * det;
		mi.v1.z = (m.v1.y * m.v2.z - m.v2.y * m.v1.z) * det;

		mi.v2.x = (m.v2.z * m.v3.x - m.v3.z * m.v2.x) * det;
		mi.v2.y = (m.v3.z * m.v1.x - m.v1.z * m.v3.x) * det;
		mi.v2.z = (m.v1.z * m.v2.x - m.v2.z * m.v1.x) * det;

		mi.v3.x = (m.v2.x * m.v3.y - m.v3.x * m.v2.y) * det;
		mi.v3.y = (m.v3.x * m.v1.y - m.v1.x * m.v3.y) * det;
		mi.v3.z = (m.v1.x * m.v2.y - m.v2.x * m.v1.y) * det;

		return mi;
	}

	void Normalize(void)
	{
		v1.Normalize();
		v2.Normalize();
		v3.Normalize();
	}

	Matrix32 GetTensorMatrix(void) const
	{
		return Matrix32(Vector32(0.0f), Vector32(v3.z * v2.y - v3.y * v2.z, v3.x * v2.z - v3.z * v2.x, v3.y * v2.x - v3.x * v2.y), Vector32(v3.y * v1.z - v1.y * v3.z, v3.z * v1.x - v3.x * v1.z, v1.y * v3.x - v3.y * v1.x), Vector32(v1.y * v2.z - v1.z * v2.y, v1.z * v2.x - v1.x * v2.z, v1.x * v2.y - v1.y * v2.x));
	}

	void Scale(const Vector32& v)
	{
		v1 *= v.x;
		v2 *= v.y;
		v3 *= v.z;
	}

	void Scale(Float32 r)
	{
		v1 *= r;
		v2 *= r;
		v3 *= r;
	}

	Vector32& operator [](Int32 i) const { return ((Vector32*)this)[i & 3]; }

	Vector32 Scale(void) const { return Vector32(Len(v1), Len(v2), Len(v3)); }
};


+/


alias Matrix4T!(Float)		Matrix4d;  
alias Matrix4T!(Float32)	Matrix4d32;
alias Matrix4T!(Float64)	Matrix4d64;

static assert(Matrix4d32.sizeof == 16 * float.sizeof);
static assert(Matrix4d64.sizeof == 16 * double.sizeof);

//=============================================
struct Matrix4T(TYPE) if (isNumeric!TYPE) 
{
@nogc:
@safe:
pure:
nothrow:

	alias Matrix4 = Matrix4T!(TYPE);

public: /// data
	union
	{
		/*struct { TYPE _00, _01, _02, _03,
					  _10, _11, _12, _13,
					  _20, _21, _22, _23,
					  _30, _31, _32, _33; };*/

		/*struct {
			TYPE _00 = void; TYPE _01 = void; TYPE _02 = void; TYPE _03 = void;
			TYPE _10 = void; TYPE _11 = void; TYPE _12 = void; TYPE _13 = void;
			TYPE _20 = void; TYPE _21 = void; TYPE _22 = void; TYPE _23 = void;
			TYPE _30 = void; TYPE _31 = void; TYPE _32 = void; TYPE _33 = void;
		};*/
		struct {
			TYPE _00 = 1.0f; TYPE _01 = 0.0f; TYPE _02 = 0.0f; TYPE _03 = 0.0f;
			TYPE _10 = 0.0f; TYPE _11 = 1.0f; TYPE _12 = 0.0f; TYPE _13 = 0.0f;
			TYPE _20 = 0.0f; TYPE _21 = 0.0f; TYPE _22 = 1.0f; TYPE _23 = 0.0f;
			TYPE _30 = 0.0f; TYPE _31 = 0.0f; TYPE _32 = 0.0f; TYPE _33 = 1.0f;
		};
		TYPE m_prElements[4][4] = void;
		TYPE m_prArray[16]      = void;
	};
public:
	/// CTor's
	this(_DONTCONSTRUCT dc) pure nothrow { } //_Matrix4(_DONTCONSTRUCT v) { }

	
	this(_INITTCONSTRUCT ic) pure nothrow {
		_00 = 1.0f; _01 = 0.0f; _02 = 0.0f; _03 = 0.0f;
		_10 = 0.0f; _11 = 1.0f; _12 = 0.0f; _13 = 0.0f;
		_20 = 0.0f; _21 = 0.0f; _22 = 1.0f; _23 = 0.0f;
		_30 = 0.0f; _31 = 0.0f; _32 = 0.0f; _33 = 1.0f;
	}

	this(TYPE m00, TYPE m01, TYPE m02, TYPE m03,
		 TYPE m10, TYPE m11, TYPE m12, TYPE m13,
		 TYPE m20, TYPE m21, TYPE m22, TYPE m23,
		 TYPE m30, TYPE m31, TYPE m32, TYPE m33)
	{
		_00 = m00; _01 = m01; _02 = m02; _03 = m03;
		_10 = m10; _11 = m11; _12 = m12; _13 = m13;
		_20 = m20; _21 = m21; _22 = m22; _23 = m23;
		_30 = m30; _31 = m31; _32 = m32; _33 = m33;
	}

	this(TYPE* p) @system {
		for (Int32 i = 0; i < 16; i++){ m_prArray[i] = p[i]; }
	}


	this(U : TYPE)(auto ref const Matrix4T!(U) m) {
		for (Int32 i = 0; i < 16; i++) { m_prArray[i] = m.m_prArray[i]; }
	}

	this(U : TYPE)(auto ref const MatrixT!(U) m)	{
		_00 = cast(TYPE)m.v1.x; _01 = cast(TYPE)m.v2.x; _02 = cast(TYPE)m.v3.x; _03 = cast(TYPE)m.off.x;
		_10 = cast(TYPE)m.v1.y; _11 = cast(TYPE)m.v2.y; _12 = cast(TYPE)m.v3.y; _13 = cast(TYPE)m.off.y;
		_20 = cast(TYPE)m.v1.z; _21 = cast(TYPE)m.v2.z; _22 = cast(TYPE)m.v3.z; _23 = cast(TYPE)m.off.z;
		_30 = cast(TYPE)0.0;	_31 = cast(TYPE)0.0;	_32 = cast(TYPE)0.0;	_33 = cast(TYPE)1.0;
	}

	Matrix32 GetSMatrix() {
		Matrix32 m = Matrix32(DC);
		m.v1.x = cast(Float32)_00; m.v2.x = cast(Float32)_01; m.v3.x = cast(Float32)_02; m.off.x = cast(Float32)_03;
		m.v1.y = cast(Float32)_10; m.v2.y = cast(Float32)_11; m.v3.y = cast(Float32)_12; m.off.y = cast(Float32)_13;
		m.v1.z = cast(Float32)_20; m.v2.z = cast(Float32)_21; m.v3.z = cast(Float32)_22; m.off.z = cast(Float32)_23;
		return m;
	}

	Matrix64 GetLMatrix() {
		Matrix64 m = Matrix64(DC);
		m.v1.x = cast(Float64)_00; m.v2.x = cast(Float64)_01; m.v3.x = cast(Float64)_02; m.off.x = cast(Float64)_03;
		m.v1.y = cast(Float64)_10; m.v2.y = cast(Float64)_11; m.v3.y = cast(Float64)_12; m.off.y = cast(Float64)_13;
		m.v1.z = cast(Float64)_20; m.v2.z = cast(Float64)_21; m.v3.z = cast(Float64)_22; m.off.z = cast(Float64)_23;
		return m;
	}
/+
	friend const _Matrix4 operator * (const _Matrix4& m1, const _Matrix4& m2)
	{
		Int32		 i, j, k;
		_Matrix4 r(DC);
		r.SetZero();

		for (i = 0; i < 4; i++)
		{
			for (k = 0; k < 4; k++)
			{
				for (j = 0; j < 4; j++)
				{
					r.m_prElements[i][j] += m1.m_prElements[i][k] * m2.m_prElements[k][j];
				}
			}
		}
		return r;
	}

	friend const Vector4d64 operator * (const _Matrix4& m, const Vector4d64& v)
	{
		Vector4d64 r(0.0f);
		Int32			 i, k;

		for (i = 0; i < 4; i++)
		{
			for (k = 0; k < 4; k++)
			{
				r.m_prElements[i] += m.m_prElements[i][k] * v.m_prElements[k];
			}
		}
		return r;
	}

	friend const Vector4d32 operator * (const _Matrix4& m, const Vector4d32& v)
	{
		Vector4d32 r(0.0f);
		Int32			 i, k;

		for (i = 0; i < 4; i++)
		{
			for (k = 0; k < 4; k++)
			{
				r.m_prElements[i] += m.m_prElements[i][k] * v.m_prElements[k];
			}
		}
		return r;
	}

	friend const Vector32 operator * (const _Matrix4& m, const Vector32& v)
	{
		Vector4d32 t(v);
		Vector4d32 r(0.0f);
		Int32			 i, k;

		for (i = 0; i < 4; i++)
		{
			for (k = 0; k < 4; k++)
			{
				r.m_prElements[i] += m.m_prElements[i][k] * t.m_prElements[k];
			}
		}
		r.MakeVector3();
		return Vector32(r.x, r.y, r.z);
	}

	friend const Vector64 operator * (const _Matrix4& m, const Vector64& v)
	{
		Vector4d64 t(v);
		Vector4d64 r(0.0);
		Int32			 i, k;

		for (i = 0; i < 4; i++)
		{
			for (k = 0; k < 4; k++)
			{
				r.m_prElements[i] += m.m_prElements[i][k] * t.m_prElements[k];
			}
		}
		r.MakeVector3();
		return Vector64(r.x, r.y, r.z);
	}
+/
	Matrix4 GetTranspose() const
	{
		//Matrix4 r = Matrix4(DC); //Error: no property 'opCall' for type 'c4d_matrix.Matrix4T!double.Matrix4T'
		Matrix4 r;
		Int32	i, j;
		for (i = 0; i < 4; i++)	{
			for (j = 0; j < 4; j++)
				r.m_prElements[i][j] = m_prElements[j][i];
		}
		return r;
	}
/+
	friend const Matrix4 operator ! (const Matrix4& m)
	{
		Matrix4 r(DC);

		r._00 =  Det(m._11, m._12, m._13, m._21, m._22, m._23, m._31, m._32, m._33);
		r._01 = -Det(m._01, m._02, m._03, m._21, m._22, m._23, m._31, m._32, m._33);
		r._02 =  Det(m._01, m._02, m._03, m._11, m._12, m._13, m._31, m._32, m._33);
		r._03 = -Det(m._01, m._02, m._03, m._11, m._12, m._13, m._21, m._22, m._23);
		r._10 = -Det(m._10, m._12, m._13, m._20, m._22, m._23, m._30, m._32, m._33);
		r._11 =  Det(m._00, m._02, m._03, m._20, m._22, m._23, m._30, m._32, m._33);
		r._12 = -Det(m._00, m._02, m._03, m._10, m._12, m._13, m._30, m._32, m._33);
		r._13 =  Det(m._00, m._02, m._03, m._10, m._12, m._13, m._20, m._22, m._23);
		r._20 =  Det(m._10, m._11, m._13, m._20, m._21, m._23, m._30, m._31, m._33);
		r._21 = -Det(m._00, m._01, m._03, m._20, m._21, m._23, m._30, m._31, m._33);
		r._22 =  Det(m._00, m._01, m._03, m._10, m._11, m._13, m._30, m._31, m._33);
		r._23 = -Det(m._00, m._01, m._03, m._10, m._11, m._13, m._20, m._21, m._23);
		r._30 = -Det(m._10, m._11, m._12, m._20, m._21, m._22, m._30, m._31, m._32);
		r._31 =  Det(m._00, m._01, m._02, m._20, m._21, m._22, m._30, m._31, m._32);
		r._32 = -Det(m._00, m._01, m._02, m._10, m._11, m._12, m._30, m._31, m._32);
		r._33 =  Det(m._00, m._01, m._02, m._10, m._11, m._12, m._20, m._21, m._22);
		TYPE det = m._00 * r._00 + m._10 * r._01 + m._20 * r._02 + m._30 * r._03;
		if (det == 0)
		{
			r = _Matrix4();
			return r;
		}
		det = 1.0f / det;
		r = det * r;
		return r;
	}

	friend const _Matrix4 operator * (const TYPE s, const _Matrix4& m)
	{
		_Matrix4 r(DC);
		Int32		 i;
		for (i = 0; i < 16; i++)
			r.m_prArray[i] = m.m_prArray[i] * s;
		return r;
	}
+/
	/// operator ==,  operator !=
	bool opEquals()(auto ref const Matrix4 rhs) const {
		/+
		for (Int32 l = 0; l < 16; l++) {
			if (m_prArray[l] != rhs.m_prArray[l]) return false;
		}
		return true;
		+/
		return (_00 == rhs._00 && _01 == rhs._01 && _02 == rhs._02 && _03 == rhs._03 && 
				_10 == rhs._10 && _11 == rhs._11 && _12 == rhs._12 && _13 == rhs._13 && 
				_20 == rhs._20 && _21 == rhs._21 && _22 == rhs._22 && _23 == rhs._23 && 
				_30 == rhs._30 && _31 == rhs._31 && _32 == rhs._32 && _33 == rhs._33 );
	}

	void SetZero() {
		_00 = _01 = _02 = _03 = 0.0;
		_10 = _11 = _12 = _13 = 0.0;
		_20 = _21 = _22 = _23 = 0.0;
		_30 = _31 = _32 = _33 = 0.0;
	}

	void SetOffset(ref const Vector v) {
		_03 = v.x;
		_13 = v.y;
		_23 = v.z;
	}

	void Scale(TYPE r) {
		_33 /= r;
	}

	void ScaleDirections(TYPE r) {
		_00 *= r; _01 *= r; _02 *= r;
		_10 *= r; _11 *= r; _12 *= r;
		_20 *= r; _21 *= r; _22 *= r;
	}

	Bool IsInvertable() {
		Matrix4 r = (DC);

		r._00 =  Det(_11, _12, _13, _21, _22, _23, _31, _32, _33);
		r._01 = -Det(_01, _02, _03, _21, _22, _23, _31, _32, _33);
		r._02 =  Det(_01, _02, _03, _11, _12, _13, _31, _32, _33);
		r._03 = -Det(_01, _02, _03, _11, _12, _13, _21, _22, _23);
		r._10 = -Det(_10, _12, _13, _20, _22, _23, _30, _32, _33);
		r._11 =  Det(_00, _02, _03, _20, _22, _23, _30, _32, _33);
		r._12 = -Det(_00, _02, _03, _10, _12, _13, _30, _32, _33);
		r._13 =  Det(_00, _02, _03, _10, _12, _13, _20, _22, _23);
		r._20 =  Det(_10, _11, _13, _20, _21, _23, _30, _31, _33);
		r._21 = -Det(_00, _01, _03, _20, _21, _23, _30, _31, _33);
		r._22 =  Det(_00, _01, _03, _10, _11, _13, _30, _31, _33);
		r._23 = -Det(_00, _01, _03, _10, _11, _13, _20, _21, _23);
		r._30 = -Det(_10, _11, _12, _20, _21, _22, _30, _31, _32);
		r._31 =  Det(_00, _01, _02, _20, _21, _22, _30, _31, _32);
		r._32 = -Det(_00, _01, _02, _10, _11, _12, _30, _31, _32);
		r._33 =  Det(_00, _01, _02, _10, _11, _12, _20, _21, _22);
		TYPE det = _00 * r._00 + _10 * r._01 + _20 * r._02 + _30 * r._03;
		if (det == 0.0)	{
			return false;
		}
		return true;
	}


private:
	static TYPE Det(TYPE a1, TYPE a2, TYPE a3, TYPE b1, TYPE b2, TYPE b3, TYPE c1, TYPE c2, TYPE c3)
	{
		return a1 * (b2 * c3 - b3 * c2) - b1 * (a2 * c3 - a3 * c2) + c1 * (a2 * b3 - a3 * b2);
	}
};


/+
#ifdef __FLOAT_32_BIT
	#define Matrix4d Matrix4d32
	#define RMtoSM4(x) (x)
	#define SMtoRM4(x) (x)
	inline Matrix4d64 RMtoLM4(const Matrix4d& m)
	{
		return Matrix4d64((Float64)m._00, (Float64)m._01, (Float64)m._02, (Float64)m._03,
										(Float64)m._10, (Float64)m._11, (Float64)m._12, (Float64)m._13,
										(Float64)m._20, (Float64)m._21, (Float64)m._22, (Float64)m._23,
										(Float64)m._30, (Float64)m._31, (Float64)m._32, (Float64)m._33);
	}
#else
	#define Matrix4d Matrix4d64
	inline Matrix4d32 RMtoSM4(const Matrix4d& m)
	{
		return Matrix4d32((Float32)m._00, (Float32)m._01, (Float32)m._02, (Float32)m._03,
										(Float32)m._10, (Float32)m._11, (Float32)m._12, (Float32)m._13,
										(Float32)m._20, (Float32)m._21, (Float32)m._22, (Float32)m._23,
										(Float32)m._30, (Float32)m._31, (Float32)m._32, (Float32)m._33);
	}
	inline Matrix4d SMtoRM4(const Matrix4d32& m)
	{
		return Matrix4d((Float)m._00, (Float)m._01, (Float)m._02, (Float)m._03,
										(Float)m._10, (Float)m._11, (Float)m._12, (Float)m._13,
										(Float)m._20, (Float)m._21, (Float)m._22, (Float)m._23,
										(Float)m._30, (Float)m._31, (Float)m._32, (Float)m._33);
	}
	#define RMtoLM4(m) (m)
#endif
+/

unittest //####################################################################
{
	Matrix32 m32;
	Matrix64 m64;

	const Matrix4d m0 = (m32);
	const Matrix4d m1 = (m64);

	const Matrix4d m2 = Matrix4d(m32);
	const Matrix4d m3 = Matrix4d(m64);

	//static assert(m0 == m2);
	//? assert(m0 == m2); //wrong !?

	static assert(Matrix4d(1.0f, 0.0f, 0.0f, 0.0f,
						   0.0f, 1.0f, 0.0f, 0.0f,
						   0.0f, 0.0f, 1.0f, 0.0f,
						   0.0f, 0.0f, 0.0f, 1.0f,   
						   ) == Matrix4d(1.0f, 0.0f, 0.0f, 0.0f,
										 0.0f, 1.0f, 0.0f, 0.0f,
										 0.0f, 0.0f, 1.0f, 0.0f,
										 0.0f, 0.0f, 0.0f, 1.0f, 
										)
				  );
}