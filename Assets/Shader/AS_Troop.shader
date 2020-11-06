// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Mantis/Standard/AS_Troop"
{
	Properties
	{
		_Albedo("Albedo", 2D) = "white" {}
		_Color("Color", Color) = (1,1,1,1)
		_Normal("Normal", 2D) = "bump" {}
		_Emission("Emission", 2D) = "white" {}
		[HDR]_EmissionColor("Emission Color", Color) = (0,0,0,0)
		_EmissionPower("Emission Power", Range( 0 , 1)) = 0
		_Metalness("Metallic", Range( 0 , 1)) = 0
		_Smothness("Roughness", Range( 0 , 1)) = 0
		_OcclusionPower("Ambient Occlusion", Range( 0 , 1)) = 1
		_NormalScale("NormalScale", Range( 0 , 4)) = 1
		_Mix("Mix", 2D) = "white" {}
		_AggroIntensity("AggroIntensity", Range( 0 , 1)) = 1
		_Src("Src", Float) = 0
		_Dst("Dst", Float) = 0
		[Enum(Opaque,0,TransparentCutout,1,Fade,2,Transparent,3)]_RenderingMode("RenderingMode", Int) = 0
		_HitLevel("Hit Level", Range( 0 , 1)) = 0
		_Dissolve_Intensity("Dissolve Intensity", Range( 0 , 1)) = 0
		_Eroder("Eroder", 2D) = "white" {}
		_EdgeThickness("EdgeThickness", Range( 0 , 1)) = 0.2242211
		[HDR]_DissolveColor("Dissolve Color", Color) = (0.3015308,4.110184,5.811321,0)
		_DissolveMaximum("DissolveHeight", Float) = 5
		[Toggle]_InvertDirection("InvertDirection", Float) = 0
		[Toggle]_DissolveHorizontal("DissolveHorizontal", Float) = 0
		[HideInInspector]_PetrifyTexture("PetrifyTexture", 2D) = "white" {}
		[HideInInspector]_PetrifyEroder("PetrifyEroder", 2D) = "white" {}
		[Toggle]_PetrifyHorizontal("PetrifyHorizontal", Float) = 0
		[Toggle]_PetrifyInvertDirection("PetrifyInvertDirection", Float) = 0
		[HideInInspector]_PetrifyIntensity("PetrifyIntensity", Range( 0 , 1)) = 0
		[HideInInspector]_PetrifyMaxDistance("PetrifyMaxDistance", Float) = 1
		[HideInInspector]_PetrifyMinDistance("PetrifyMinDistance", Float) = -1
		[HideInInspector]_PetrifyMultiply("PetrifyMultiply", Float) = 1
		[HideInInspector]_HealIntensity("HealIntensity", Range( 0 , 1)) = 0
		[HideInInspector]_HealTexture("HealTexture", 2D) = "white" {}
		[HideInInspector]_SpeedIntensity("SpeedIntensity", Range( 0 , 1)) = 0
		[HideInInspector]_AcidIntensity("AcidIntensity", Range( 0 , 1)) = 0
		[HideInInspector]_SlowIntensity("SlowIntensity", Range( 0 , 1)) = 0
		[HideInInspector]_StunIntensity("StunIntensity", Range( 0 , 1)) = 0
		[HideInInspector]_AcidDamage("AcidDamage", Range( 0 , 1)) = 0
		[HideInInspector]_StatusTexture("StatusTexture", 2D) = "white" {}
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		_CullingMode("CullingMode", Range( 0 , 2)) = 2
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull [_CullingMode]
		ZWrite On
		Blend [_Src] [_Dst]
		
		CGINCLUDE
		#include "UnityStandardUtils.cginc"
		#include "UnityShaderVariables.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		#ifdef UNITY_PASS_SHADOWCASTER
			#undef INTERNAL_DATA
			#undef WorldReflectionVector
			#undef WorldNormalVector
			#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
			#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
			#define WorldNormalVector(data,normal) half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))
		#endif
		struct Input
		{
			float2 uv_texcoord;
			float3 worldPos;
			float3 worldNormal;
			INTERNAL_DATA
			half ASEVFace : VFACE;
		};

		uniform float _CullingMode;
		uniform float _Src;
		uniform int _RenderingMode;
		uniform float _Dst;
		uniform float _NormalScale;
		uniform sampler2D _Normal;
		uniform sampler2D _Albedo;
		uniform float4 _Albedo_ST;
		uniform float4 _Color;
		uniform sampler2D _PetrifyTexture;
		uniform float4 _PetrifyTexture_ST;
		uniform sampler2D _PetrifyEroder;
		uniform float4 _PetrifyEroder_ST;
		uniform float _PetrifyMinDistance;
		uniform float _PetrifyInvertDirection;
		uniform float _PetrifyHorizontal;
		uniform float _PetrifyMultiply;
		uniform float _PetrifyMaxDistance;
		uniform float _PetrifyIntensity;
		uniform float _HitLevel;
		uniform sampler2D _Emission;
		uniform float4 _EmissionColor;
		uniform float _EmissionPower;
		uniform float4 _DissolveColor;
		uniform sampler2D _Eroder;
		uniform float4 _Eroder_ST;
		uniform float _InvertDirection;
		uniform float _DissolveHorizontal;
		uniform float _DissolveMaximum;
		uniform float _Dissolve_Intensity;
		uniform float _EdgeThickness;
		uniform sampler2D _HealTexture;
		uniform float _HealIntensity;
		uniform sampler2D _StatusTexture;
		uniform float _StunIntensity;
		uniform float _SpeedIntensity;
		uniform float _SlowIntensity;
		uniform float _AcidIntensity;
		uniform float _AcidDamage;
		uniform float _AggroIntensity;
		uniform sampler2D _Mix;
		uniform float4 _Mix_ST;
		uniform float _Metalness;
		uniform float _Smothness;
		uniform float _OcclusionPower;
		uniform float _Cutoff = 0.5;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv0_Albedo = i.uv_texcoord * _Albedo_ST.xy + _Albedo_ST.zw;
			float3 temp_output_217_6 = UnpackScaleNormal( tex2D( _Normal, uv0_Albedo ), _NormalScale );
			o.Normal = temp_output_217_6;
			float4 tex2DNode1_g4 = tex2D( _Albedo, uv0_Albedo );
			float4 color28_g5 = IsGammaSpace() ? float4(0.7735849,0.7735849,0.7735849,1) : float4(0.5600193,0.5600193,0.5600193,1);
			float2 uv_PetrifyTexture = i.uv_texcoord * _PetrifyTexture_ST.xy + _PetrifyTexture_ST.zw;
			float2 uv_PetrifyEroder = i.uv_texcoord * _PetrifyEroder_ST.xy + _PetrifyEroder_ST.zw;
			float3 ase_vertex3Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float temp_output_21_0_g5 = ( ( lerp(ase_vertex3Pos.y,ase_vertex3Pos.x,_PetrifyHorizontal) / 2.0 ) + 0.5 );
			float lerpResult23_g5 = lerp( _PetrifyMinDistance , ( ( lerp(temp_output_21_0_g5,( 1.0 - temp_output_21_0_g5 ),_PetrifyInvertDirection) * _PetrifyMultiply ) + _PetrifyMaxDistance ) , _PetrifyIntensity);
			float temp_output_201_31 = saturate( ( (0.0 + (tex2D( _PetrifyEroder, uv_PetrifyEroder ).r - 0.0) * (1.0 - 0.0) / (1.0 - 0.0)) + lerpResult23_g5 ) );
			float4 lerpResult75 = lerp( ( tex2DNode1_g4 * _Color ) , ( color28_g5 * tex2D( _PetrifyTexture, uv_PetrifyTexture ) ) , temp_output_201_31);
			o.Albedo = lerpResult75.rgb;
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float fresnelNdotV6_g231 = dot( ase_worldNormal, ase_worldViewDir );
			float fresnelNode6_g231 = ( 0.0 + 1.0 * pow( 1.0 - fresnelNdotV6_g231, 2.0 ) );
			float4 lerpResult4_g231 = lerp( float4( 0,0,0,0 ) , ( float4(2.270603,2.270603,2.270603,0) * fresnelNode6_g231 ) , _HitLevel);
			float4 lerpResult15_g4 = lerp( float4( 0,0,0,0 ) , ( tex2D( _Emission, uv0_Albedo ) * _EmissionColor ) , _EmissionPower);
			float2 uv_Eroder = i.uv_texcoord * _Eroder_ST.xy + _Eroder_ST.zw;
			float lerpResult98_g3 = lerp( ( ( lerp(( 1.0 - lerp(ase_vertex3Pos.x,ase_vertex3Pos.y,_DissolveHorizontal) ),lerp(ase_vertex3Pos.x,ase_vertex3Pos.y,_DissolveHorizontal),_InvertDirection) + -2.0 ) - lerp(( 1.0 - lerp(ase_vertex3Pos.x,ase_vertex3Pos.y,_DissolveHorizontal) ),lerp(ase_vertex3Pos.x,ase_vertex3Pos.y,_DissolveHorizontal),_InvertDirection) ) , ( ( lerp(( 1.0 - lerp(ase_vertex3Pos.x,ase_vertex3Pos.y,_DissolveHorizontal) ),lerp(ase_vertex3Pos.x,ase_vertex3Pos.y,_DissolveHorizontal),_InvertDirection) + _DissolveMaximum ) - 0.0 ) , _Dissolve_Intensity);
			float temp_output_92_0_g3 = ( tex2D( _Eroder, uv_Eroder ).r + lerpResult98_g3 );
			float2 panner4_g229 = ( 1.0 * _Time.y * float2( 0.1,-0.1 ) + i.uv_texcoord);
			float4 color7_g229 = IsGammaSpace() ? float4(0.2522631,3.441591,0.6235944,1) : float4(0.0517868,15.16598,0.3467838,1);
			float fresnelNdotV9_g229 = dot( ase_worldNormal, ase_worldViewDir );
			float fresnelNode9_g229 = ( 0.0 + 1.0 * pow( 1.0 - fresnelNdotV9_g229, 1.8 ) );
			float4 color10_g230 = IsGammaSpace() ? float4(1.56705,1.298675,1.976675,0) : float4(2.686472,1.777056,4.477727,0);
			float fresnelNdotV8_g230 = dot( ase_worldNormal, ase_worldViewDir );
			float fresnelNode8_g230 = ( 0.0 + 1.0 * pow( 1.0 - fresnelNdotV8_g230, 1.6 ) );
			float2 panner2_g230 = ( 1.0 * _Time.y * float2( 0.3,-0.3 ) + ( float3( float2( 0.3,1 ) ,  0.0 ) * ase_vertex3Pos ).xy);
			float4 color21_g230 = IsGammaSpace() ? float4(0.8486246,1.57306,1.976675,0) : float4(0.6895495,2.709191,4.477727,0);
			float fresnelNdotV23_g230 = dot( ase_worldNormal, ase_worldViewDir );
			float fresnelNode23_g230 = ( 0.0 + 1.0 * pow( 1.0 - fresnelNdotV23_g230, 1.8 ) );
			float2 panner15_g230 = ( 1.0 * _Time.y * float2( 0,-0.4 ) + ( float3( float2( 2,0.3 ) ,  0.0 ) * ase_vertex3Pos ).xy);
			float4 color32_g230 = IsGammaSpace() ? float4(1.304119,1.17439,0.8329974,0) : float4(1.793486,1.424253,0.6612751,0);
			float fresnelNdotV33_g230 = dot( ase_worldNormal, ase_worldViewDir );
			float fresnelNode33_g230 = ( 0.0 + 1.0 * pow( 1.0 - fresnelNdotV33_g230, 1.0 ) );
			float2 panner25_g230 = ( 1.0 * _Time.y * float2( 0,0.2 ) + ( float3( float2( 2,0.3 ) ,  0.0 ) * ase_vertex3Pos ).xy);
			float4 color35_g230 = IsGammaSpace() ? float4(0.6526234,1,0.2980392,0) : float4(0.3834594,1,0.07227185,0);
			float fresnelNdotV36_g230 = dot( ase_worldNormal, ase_worldViewDir );
			float fresnelNode36_g230 = ( 0.0 + 1.0 * pow( 1.0 - fresnelNdotV36_g230, 1.0 ) );
			float2 panner40_g230 = ( 1.0 * _Time.y * float2( 0,-0.2 ) + ase_vertex3Pos.xy);
			float lerpResult37_g230 = lerp( 1.0 , 5.0 , _AcidDamage);
			float3 ase_worldTangent = WorldNormalVector( i, float3( 1, 0, 0 ) );
			float3 ase_worldBitangent = WorldNormalVector( i, float3( 0, 1, 0 ) );
			float3x3 ase_tangentToWorldFast = float3x3(ase_worldTangent.x,ase_worldBitangent.x,ase_worldNormal.x,ase_worldTangent.y,ase_worldBitangent.y,ase_worldNormal.y,ase_worldTangent.z,ase_worldBitangent.z,ase_worldNormal.z);
			float fresnelNdotV6_g234 = dot( mul(ase_tangentToWorldFast,float4( temp_output_217_6 , 0.0 ).xyz), ase_worldViewDir );
			float fresnelNode6_g234 = ( 0.0 + 1.0 * pow( 1.0 - fresnelNdotV6_g234, 3.0 ) );
			float4 lerpResult4_g234 = lerp( float4( 0,0,0,0 ) , ( (0.2 + (i.ASEVFace - -1.0) * (1.0 - 0.2) / (1.0 - -1.0)) * ( float4(2.608238,0.171709,0.1304119,0) * fresnelNode6_g234 ) ) , _AggroIntensity);
			o.Emission = ( lerpResult4_g231 + ( lerpResult15_g4 + ( _DissolveColor * ( 1.0 - step( temp_output_92_0_g3 , ( _Dissolve_Intensity + (0.0 + (_EdgeThickness - 0.0) * (-0.3 - 0.0) / (1.0 - 0.0)) ) ) ) ) ) + ( tex2D( _HealTexture, panner4_g229 ) * color7_g229 * _HealIntensity * fresnelNode9_g229 ) + ( ( color10_g230 * fresnelNode8_g230 * tex2D( _StatusTexture, panner2_g230 ) * _StunIntensity ) + ( color21_g230 * fresnelNode23_g230 * tex2D( _StatusTexture, panner15_g230 ) * _SpeedIntensity ) + ( color32_g230 * fresnelNode33_g230 * tex2D( _StatusTexture, panner25_g230 ) * _SlowIntensity ) + ( color35_g230 * fresnelNode36_g230 * tex2D( _StatusTexture, panner40_g230 ) * _AcidIntensity * lerpResult37_g230 ) ) + lerpResult4_g234 ).rgb;
			float2 uv_Mix = i.uv_texcoord * _Mix_ST.xy + _Mix_ST.zw;
			float4 tex2DNode43_g4 = tex2D( _Mix, uv_Mix );
			float lerpResult23_g4 = lerp( 0.0 , tex2DNode43_g4.r , _Metalness);
			float clampResult29_g4 = clamp( lerpResult23_g4 , 0.0 , 1.0 );
			float lerpResult85 = lerp( clampResult29_g4 , 0.0 , temp_output_201_31);
			o.Metallic = saturate( lerpResult85 );
			float lerpResult28_g4 = lerp( 0.0 , ( 1.0 - tex2DNode43_g4.g ) , _Smothness);
			float lerpResult91 = lerp( lerpResult28_g4 , 0.5 , temp_output_201_31);
			o.Smoothness = lerpResult91;
			float lerpResult19_g4 = lerp( 1.0 , tex2DNode43_g4.b , _OcclusionPower);
			o.Occlusion = lerpResult19_g4;
			float _DissolveValue89_g3 = _Dissolve_Intensity;
			float clampResult21_g3 = clamp( step( temp_output_92_0_g3 , _DissolveValue89_g3 ) , 0.0 , 1.0 );
			float clampResult22 = clamp( ( ( tex2DNode1_g4.a * _Color.a ) * clampResult21_g3 ) , 0.0 , 1.0 );
			o.Alpha = clampResult22;
			clip( clampResult22 - _Cutoff );
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Standard keepalpha fullforwardshadows noshadow 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			sampler3D _DitherMaskLOD;
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float4 tSpace0 : TEXCOORD2;
				float4 tSpace1 : TEXCOORD3;
				float4 tSpace2 : TEXCOORD4;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				half3 worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
				half tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				half3 worldBinormal = cross( worldNormal, worldTangent ) * tangentSign;
				o.tSpace0 = float4( worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x );
				o.tSpace1 = float4( worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y );
				o.tSpace2 = float4( worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z );
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_texcoord = IN.customPack1.xy;
				float3 worldPos = float3( IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w );
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldPos = worldPos;
				surfIN.worldNormal = float3( IN.tSpace0.z, IN.tSpace1.z, IN.tSpace2.z );
				surfIN.internalSurfaceTtoW0 = IN.tSpace0.xyz;
				surfIN.internalSurfaceTtoW1 = IN.tSpace1.xyz;
				surfIN.internalSurfaceTtoW2 = IN.tSpace2.xyz;
				SurfaceOutputStandard o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandard, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				half alphaRef = tex3D( _DitherMaskLOD, float3( vpos.xy * 0.25, o.Alpha * 0.9375 ) ).a;
				clip( alphaRef - 0.01 );
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "TroopShaderCustomGUI"
}
/*ASEBEGIN
Version=17000
1923;44;1906;1005;1193.989;1179.908;1.680072;True;True
Node;AmplifyShaderEditor.FunctionNode;199;-448.7768,-218.0003;Float;True;F_Dissolve;19;;3;15f05b5dc145b0e4bb3670d5ee688507;0;0;2;COLOR;0;FLOAT;23
Node;AmplifyShaderEditor.FunctionNode;217;-378.7928,-477.9766;Float;False;PBRHDFlow;0;;4;6f5b80b068b663f4f8d36397b6cfeeaf;0;0;7;COLOR;0;FLOAT3;6;COLOR;14;FLOAT;21;FLOAT;26;FLOAT;18;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;201;-184.7819,-649.0148;Float;False;F_PetrifyEffect;27;;5;bbb61e176eec2dd438c5dccecd860ecd;0;0;4;FLOAT;44;FLOAT;45;FLOAT;31;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;192;-120.3165,23.1303;Float;False;F_Heal;36;;229;768d8e0f30fd7614cb6dc49bf99f4b82;0;0;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;212;123.9392,-141.6267;Float;False;F_HitEffect;17;;231;dcdb023afe261e6409d8d816deb5a2cb;0;0;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;205;-165.9423,105.317;Float;False;F_StatusEffects;39;;230;f382ca42a9850834d91ca1f48aca9207;0;0;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;224;-103.2204,178.5599;Float;False;F_Aggro;12;;234;5fb05f18ab89df24ab1483158e3cd2ca;0;1;8;FLOAT4;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;41;48.55463,-305.3855;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;17;76.81616,-73.92645;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;85;281.0295,-400.308;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;131;312.2656,-821.1378;Float;False;Property;_CullingMode;CullingMode;47;0;Create;True;0;0;True;0;2;0;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;214;21.28304,-821.6273;Float;False;Property;_Src;Src;14;0;Create;True;0;0;True;0;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.IntNode;213;591.7796,-825.9401;Float;False;Property;_RenderingMode;RenderingMode;16;1;[Enum];Create;True;4;Opaque;0;TransparentCutout;1;Fade;2;Transparent;3;0;True;0;0;0;0;1;INT;0
Node;AmplifyShaderEditor.RangedFloatNode;215;156.283,-820.6273;Float;False;Property;_Dst;Dst;15;0;Create;True;0;0;True;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;90;458.2922,-400.6542;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;18;514.9952,-3.235956;Float;False;5;5;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;91;641.2922,-369.6542;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;22;251.5704,-271.8817;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;75;342.9783,-544.6832;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;37;1025.148,-454.6824;Float;False;True;2;Float;TroopShaderCustomGUI;0;0;Standard;Mantis/Standard/AS_Troop;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Off;1;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;7;Custom;0.5;True;True;0;True;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;True;214;10;True;215;0;5;False;-1;10;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;46;-1;-1;-1;0;False;0;0;True;131;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;224;8;217;6
WireConnection;41;0;217;4
WireConnection;41;1;199;23
WireConnection;17;0;217;14
WireConnection;17;1;199;0
WireConnection;85;0;217;21
WireConnection;85;1;201;44
WireConnection;85;2;201;31
WireConnection;90;0;85;0
WireConnection;18;0;212;0
WireConnection;18;1;17;0
WireConnection;18;2;192;0
WireConnection;18;3;205;0
WireConnection;18;4;224;0
WireConnection;91;0;217;26
WireConnection;91;1;201;45
WireConnection;91;2;201;31
WireConnection;22;0;41;0
WireConnection;75;0;217;0
WireConnection;75;1;201;0
WireConnection;75;2;201;31
WireConnection;37;0;75;0
WireConnection;37;1;217;6
WireConnection;37;2;18;0
WireConnection;37;3;90;0
WireConnection;37;4;91;0
WireConnection;37;5;217;18
WireConnection;37;9;22;0
WireConnection;37;10;22;0
ASEEND*/
//CHKSM=5A602EF71F5D7FC421541F8CB8AFF740D42085AF