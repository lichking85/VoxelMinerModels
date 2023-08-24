Shader "HighlightPlus/Geometry/DepthClipComp"
{
	Properties
	{
	}
	SubShader
	{
        Pass {
            Name "ShadowCaster"
            Tags { "LightMode" = "ShadowCaster" }

        CGPROGRAM
        #pragma vertex vert
        #pragma fragment frag
        #pragma target 2.0
        #pragma multi_compile_shadowcaster
        #pragma multi_compile_instancing
        #include "UnityCG.cginc"

        struct interpolators {
            V2F_SHADOW_CASTER;
            UNITY_VERTEX_OUTPUT_STEREO
        };

        interpolators vert( appdata_base v ) {
            interpolators o;
            UNITY_SETUP_INSTANCE_ID(v);
            UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
            TRANSFER_SHADOW_CASTER_NORMALOFFSET(o)
            return o;
        }

        float4 frag( interpolators i ) : SV_Target {
            SHADOW_CASTER_FRAGMENT(i)
        }
        ENDCG

        }

    }

}

