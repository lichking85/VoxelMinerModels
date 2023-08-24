Shader "Unlit/Fog"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Color ("Color", Color) = (1,1,1,1)
        _Intensity("Intensity", Float) = 1
    }
    SubShader
    {
        Tags { "RenderType"="Transparent"
               "Queue" = "Transparent" }
        LOD 100

        Pass
        {
            Cull Off
            Blend One One 
            ZWrite Off
            
            CGPROGRAM

            #include "UnityCG.cginc"

            float _Intensity;
            float4 _Color;

            struct MeshData
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

            v2f vert (MeshData v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }

            float4 frag (v2f i) : SV_Target
            {
                float3 fadeEffect = (1 - i.uv.yyy) / _Intensity;   
                return _Color;
            }
            ENDCG
        }
    }
}
