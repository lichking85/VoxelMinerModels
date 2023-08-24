Shader "Unlit/CubeShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Color ("Color" , Color) = (1,1,1,1)
        _Intensity("Intencity", Float) = 1
    }
    SubShader
    {
        Tags {"RenderType"="Transparent"
                "Queue"="Transparent"
        }
        LOD 100

        Pass
        {
            Cull Off
            Blend One One 
            ZWrite Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            float _Intensity;
            float4 _Color;

            struct MeshData
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
                float3 normal : NORMAL;
            };

            struct interpolators
            {
                float2 uv : TEXCOORD0;
                float3 worldNormal : NORMAL;
                float4 vertex : SV_POSITION;
                float mask : TEXCOORD01;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

            interpolators vert (MeshData v)
            {
                interpolators o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                o.worldNormal = UnityObjectToWorldNormal(v.normal);
                bool cutTop = (1 - o.worldNormal.y) > 0.1;
                bool cutBot = (1 + o.worldNormal.y) > 0.1;
                o.mask = cutBot * cutTop; 
                return o;
            }

            fixed4 frag (interpolators i) : SV_Target
            {
                float3 fadeEffect = (1 - i.uv.yyy) / _Intensity;   
                return float4(_Color.xyz * fadeEffect , 1);
            }
            ENDCG
        }
    }
}
