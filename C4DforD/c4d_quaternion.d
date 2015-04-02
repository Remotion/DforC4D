/////////////////////////////////////////////////////////////
// CINEMA 4D SDK                                           //
/////////////////////////////////////////////////////////////
// (c) MAXON Computer GmbH, all rights reserved            //
// Ported from C++ by Remotion (remotion4d.net)			   //
// based on c4d_quaternion.h and c4d_quaternion.cpp		   //
/////////////////////////////////////////////////////////////
module c4d_quaternion;

public import c4d_matrix;

//? What is better replacement for ref const ?
//?  in  
//?  auto ref const



//=============================================================================
struct Quaternion
{
@nogc:
//@safe:
pure:
nothrow:

public:  /// data
	Float64	 w = 0;		// angle
	Vector64 v = Vector64(1.0, 0.0, 0.0);		// direction vector

public:
	this(_DONTCONSTRUCT vv) pure nothrow {  } //does this make sense ?

	this(_INITTCONSTRUCT ic) pure nothrow {  w = (0.0), v = Vector64(1.0, 0.0, 0.0);  }

	/// operator ==,  operator !=
	bool opEquals()(auto ref const Quaternion rhs) const {
		return (v == rhs.v && w == rhs.w);
	}

	Matrix64 GetMatrix() const	{// derive rotation matrix from quaternion
		Matrix64 m = (DC);
		m.off = Vector64(0, 0, 0);
		m.v1  = Vector64(1.0 - 2.0 * (v.y * v.y + v.z * v.z), 2.0 * (v.x * v.y - w * v.z), 2.0 * (v.x * v.z + w * v.y));
		m.v2  = Vector64(2.0 * (v.x * v.y + w * v.z), 1.0 - 2.0 * (v.x * v.x + v.z * v.z), 2.0 * (v.y * v.z - w * v.x));
		m.v3  = Vector64(2.0 * (v.x * v.z - w * v.y), 2.0 * (v.y * v.z + w * v.x), 1.0 - 2.0 * (v.x * v.x + v.y * v.y));
		return m;
	}

	void SetMatrix(in Matrix64  _m)	{
		Matrix64 m = _m;

		m.v1 = m.v1.GetNormalized;
		m.v2 = m.v2.GetNormalized;
		m.v3 = m.v3.GetNormalized;

		SetMatrixNorm(m);
	}

	void SetMatrixNorm(in Matrix64  m) {
		Float64 trace = m.v1.x + m.v2.y + m.v3.z;

		if (trace > 0.0){
			Float64 s = 0.5 / Sqrt(trace + 1.0);
			w = 0.25 / s;
			v.x = m.v2.z - m.v3.y;
			v.y = m.v3.x - m.v1.z;
			v.z = m.v1.y - m.v2.x;

			v *= s;
			v	 = -v;
		} else	{
			if ((m.v1.x > m.v2.y) && (m.v1.x > m.v3.z))	{
				Float64 s = 2.0 * Sqrt(1.0 + m.v1.x - m.v2.y - m.v3.z);
				v.x = 0.25 * s;
				Float64 s1 = 1.0 / s;
				v.y = (m.v2.x + m.v1.y) * s1;
				v.z = (m.v3.x + m.v1.z) * s1;
				w = (m.v3.y - m.v2.z) * s1;
			}
			else if (m.v2.y > m.v3.z) {
				Float64 s	 = 2.0 * Sqrt(1.0 + m.v2.y - m.v1.x - m.v3.z);
				Float64 s1 = 1.0 / s;
				v.x = (m.v2.x + m.v1.y) * s1;
				v.y = 0.25 * s;
				v.z = (m.v3.y + m.v2.z) * s1;
				w = -(m.v3.x - m.v1.z) * s1;
			} else {
				Float64 s	 = 2.0 * Sqrt(1.0 + m.v3.z - m.v1.x - m.v2.y);
				Float64 s1 = 1.0 / s;
				v.x = (m.v3.x + m.v1.z) * s1;
				v.y = (m.v3.y + m.v2.z) * s1;
				v.z = 0.25 * s;
				w = (m.v2.x - m.v1.y) * s1;
			}
		}
	}


	void SetAxis(in Vector64  ax, const Float64 ww)	{
		v = (ax.GetNormalized ) * Sin(0.5 * ww);
		w = Cos(0.5 * ww);
	}


	void SetHPB(in Vector64 hpb) {
		Quaternion qh, qp, qb;

		qh.SetAxis(Vector64(0, 1, 0), hpb.x);
		qp.SetAxis(Vector64(1, 0, 0), hpb.y);
		qb.SetAxis(Vector64(0, 0, 1), hpb.z);

		this = QMul(qb, QMul(qp, qh));
	}

}; //struct Quaternion


@nogc:
//@safe:
pure:
nothrow:

Quaternion QAdd(in Quaternion  q1, in Quaternion  q2) {
	Quaternion r;

	r.w = q1.w + q2.w;
	r.v = q1.v + q2.v;
	return r;
}

Quaternion QSub(in Quaternion  q1, in Quaternion  q2) {
	Quaternion r;

	r.w = q1.w - q2.w;
	r.v = q1.v - q2.v;
	return r;
}

Quaternion QMul(in Quaternion  q1, in Quaternion  q2) {
	Quaternion r;

	r.w = (q1.w * q2.w) - Dot(q1.v, q2.v);
	r.v = q1.w * q2.v + q2.w * q1.v + Cross(q1.v, q2.v);
	return r;
}

Quaternion QMul(in Quaternion  q, Float64 s) {
	Quaternion r = q;

	r.w *= s;
	r.v *= s;

	return r;
}


Quaternion QInvert(in Quaternion  q) {
	Quaternion r;

	r.w = -q.w;
	r.v = q.v;

	return r;
}


Quaternion QDeriv(in Quaternion  q, in Vector64  w) {
	Quaternion r;

	r.w = 0.5 * Dot(-q.v, w);
	r.v.x = 0.5 * (q.w * w.x - q.v.z * w.y + q.v.y * w.z);
	r.v.y = 0.5 * (q.v.z * w.x + q.w * w.y - q.v.x * w.z);
	r.v.z = 0.5 * (-q.v.y * w.x + q.v.x * w.y + q.w * w.z);

	return r;
}


Quaternion QNorm(in Quaternion  q) {
	Quaternion r;
	Float64		 len;

	len = Sqrt(q.w * q.w + Dot(q.v, q.v));
	if (len == 0.0)
		return q;

	r.w = q.w / len;
	r.v = q.v / len;

	return r;
}
// linear interpolation
Quaternion QSlerp(in Quaternion  q1, in Quaternion  q2, const Float64 alfa) {
	Float64		 sum, teta, beta1, beta2;
	Quaternion q, qd = q2;

	sum = q1.w * q2.w + Dot(q1.v, q2.v);

	if (sum < 0.0)
	{
		sum	 = -sum;
		qd.v = -qd.v;
		qd.w = -qd.w;
	}

	if (1.0 - sum > EPSILON5)
	{
		teta = ACos(sum);
		Float64 sn = 1.0 / Sin(teta);
		beta1 = Sin((1.0 - alfa) * teta) * sn;
		beta2 = Sin(alfa * teta) * sn;
	}
	else
	{
		beta1 = 1.0 - alfa;
		beta2 = alfa;
	}

	q.w = beta1 * q1.w + beta2 * qd.w;
	q.v.x = beta1 * q1.v.x + beta2 * qd.v.x;
	q.v.y = beta1 * q1.v.y + beta2 * qd.v.y;
	q.v.z = beta1 * q1.v.z + beta2 * qd.v.z;

	return q;
}

// cubic interpolation,  q0 = i-1, q1 = i, q2 = i+1, q3 = i+2
Quaternion QSquad(in Quaternion  q0, in Quaternion  q1, in Quaternion  q2, in Quaternion  q3, Float64 t) {
	Float64 k = 2.0 * (1.0 - t) * t;
	return QSlerp(QSlerp(q0, q3, t), QSlerp(q1, q2, t), k);
}

Quaternion QLogN(in Quaternion  q) {
	Float64		 theta, scale;
	Quaternion qq;
	scale = Sqrt(Dot(q.v, q.v));
	theta = Float64(atan2(scale, q.w));
	if (scale > 0.0)
		scale = theta / scale;
	qq.v *= scale;
	qq.w	= 0.0;
	return qq;
}

// Exp: exponentiate quaternion (where q.w==0)
Quaternion QExpQ(in Quaternion  q) {
	Float64		 theta, scale;
	Quaternion qq;
	theta = Sqrt(Dot(q.v, q.v));
	scale = 1.0;
	if (theta > 0.0)
		scale = Sin(theta) / theta;
	qq.v *= scale;
	qq.w	= Cos(theta);
	return qq;
}

static Quaternion QTangent(in Quaternion  qn_m1, in Quaternion  qn, in Quaternion  qn_p1) {
	Quaternion t1, t2;

	t1 = QMul(QInvert(qn), qn_p1);
	t2 = QMul(QInvert(qn), qn_m1);

	t1 = QLogN(t1);
	t2 = QLogN(t2);

	t1.v = (t1.v + t2.v) * (-0.25);
	t1.w = 0.0;


	//	t1 = QAdd(t1,t2);
	//	t1 = QMul(t1,-0.25);

	t1 = QExpQ(t1);
	t2 = QMul(qn, t1);
	return t2;
}

Quaternion QSpline(in Quaternion  qn_m1, in Quaternion  qn, in Quaternion  qn_p1, in Quaternion  qn_p2, Float64 t) {
	Quaternion an, an_p1;

	an = QTangent(qn_m1, qn, qn_p1);
	an_p1 = QTangent(qn, qn_p1, qn_p2);

	return QSquad(qn, an, an_p1, qn_p1, t);
}

Quaternion QBlend(in Quaternion  q1, in Quaternion  q2, const Float64 r) {
	Float64 w1 = 1.0 - r;
	Float64 w2 = r;
	Float64 qq = q1.w * q2.w + Dot(q1.v, q2.v);
	Float64 z	 = Sqrt((w1 - w2) * (w1 - w2) + 4.0 * w1 * w2 * qq * qq);
	Float64 f1 = Sqrt(w1 * (w1 - w2 + z) / (z * (w1 + w2 + z)));
	Float64 f2 = Sqrt(w2 * (w2 - w1 + z) / (z * (w1 + w2 + z)));

	Quaternion qm;
	if (qq < 0.0)
		qm = QSub(QMul(q1, f1), QMul(q2, f2));
	else
		qm = QAdd(QMul(q1, f1), QMul(q2, f2));

	return QNorm(qm);
}

static Vector64 LGetHPB(in Vector64  v1, in Vector64  v2, in Vector64  v3) {
	Vector64 rot;
	Float64	 l = Sqrt(v3.x * v3.x + v3.z * v3.z);

	if (l < 0.00001)
	{
		rot.x = 0.0;
		rot.z = ACos(Dot(Vector64(1.0, 0.0, 0.0), v1.GetNormalized ));

		if (v3.y > 0.0)
		{
			rot.y = PI05;
			if (v1.z < 0.0)
				rot.z = PI2 - rot.z;
		}
		else
		{
			rot.y = -PI05;
			if (v1.z > 0.0)
				rot.z = PI2 - rot.z;
		}
	}
	else
	{
		if (v3.z > 0.0)
			rot.x = -ASin(v3.x / l);
		else
			rot.x = PI + ASin(v3.x / l);

		if (rot.x < 0.0)
			rot.x += PI2;
		rot.y = ATan(v3.y / l);
		rot.z = ACos(Dot(Vector64(Cos(rot.x), 0.0, Sin(rot.x)), v1.GetNormalized ));
		if (v1.y > 0.0)
			rot.z = PI2 - rot.z;
	}

	if (rot.z > PI)
		rot.z = rot.z - PI2;
	return rot;
}

Vector64 Matrix64ToHPB(in Matrix64  m) {
	return LGetHPB(m.v1, m.v2, m.v3);
} 


private void LSinCos(Float64 w, ref Float64  sn, ref Float64  cn) { sn = Sin(w); cn = Cos(w); }


Matrix64 LHPBToMatrix(in Vector64  w) {
	Float64 cn, sn, ck, sk, cs, ss, cosksinn, sinksinn;

	LSinCos(w.x, ss, cs);
	LSinCos(w.y, sn, cn);
	LSinCos(w.z, sk, ck);

	cosksinn = ck * sn;
	sinksinn = sk * sn;

	return Matrix64(Vector64(0.0),
					Vector64(ck * cs - sinksinn * ss, -sk * cn, ck * ss + sinksinn * cs),
					Vector64(sk * cs + cosksinn * ss, ck * cn, sk * ss - cosksinn * cs),
					Vector64(-cn * ss, sn, cn * cs));
}


unittest //####################################################################
{

}
