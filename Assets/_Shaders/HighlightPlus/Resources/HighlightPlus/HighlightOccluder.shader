Shader "HighlightPlus/Geometry/SeeThroughOccluder" {
Properties {
    _MainTex ("Texture", 2D) = "white" {}
    _Color ("Color", Color) = (1,1,1) // not used; dummy property to avoid inspector warning "material has no _Color property"
}
    SubShader
    {
        Tags { "Queue"="Transparent+100" "RenderType"="Transparent" "DisableBatching"="True" }

        // Create mask
        Pass
        {
			Stencil {
                Ref 2
                Comp always
                Pass DecrWrap
        }
            ColorMask 0
            ZWrite Off

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct MeshData
            {
                float4 vertex : POSITION;
				UNITY_VERTEX_INPUT_INSTANCE_ID
            };

            struct interpolators
            {
				float4 pos : SV_POSITION;
				UNITY_VERTEX_OUTPUT_STEREO
            };

            interpolators vert (MeshData v)
            {
				interpolators o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_OUTPUT(interpolators, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
                o.pos = UnityObjectToClipPos(v.vertex);
                #if UNITY_REVERSED_Z
                    o.pos.z += 0.0001;
                #else
                    o.pos.z -= 0.0001;
                #endif
				return o;
            }
            
            fixed4 frag (interpolators i) : SV_Target
            {
            	return 0;
            }
            ENDCG
        }

    }
}