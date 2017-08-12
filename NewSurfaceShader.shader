Shader "Custom/SphericalDistortion"
{
    Properties
    {
        // Color property for material inspector, default to white
    	_Color ("Main Color", Color) = (1,1,1,1)
    }
    SubShader
    {
         Pass
         {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma target 3.0
            #include "UnityCG.cginc"

            float2 uv_MainTex;

            struct appdata
            {
                float4 vertex : POSITION;
    			float4 tangent : TANGENT;
    			float3 normal : NORMAL;
    			float4 texcoord : TEXCOORD0;
    			float4 texcoord1 : TEXCOORD1;
    			fixed4 color : COLOR;
            };
 
            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 pos : SV_POSITION;
                float3 color : COLOR;
            
            };

            v2f vert (appdata v)
            {
                v2f o;
                UNITY_INITIALIZE_OUTPUT(v2f,o);

                float4 vertPos = mul( UNITY_MATRIX_MV, v.vertex );
				float dist = distance( float4( 0.0f, 0.0f, 0.0f, 1.0f ), vertPos );

				vertPos.z -= dist; //Spherical transformation
				vertPos.xyz *= 0.5f; //Make geometry not exeed camera frustum

				o.pos = mul ( UNITY_MATRIX_P, vertPos );

				o.color.xyz = v.normal * 0.5f + 0.5f;
				o.color.z = 1.0f;

                return o;
            }
 
            sampler2D _MainTex;

            // color from the material
            fixed4 _Color;

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 col = tex2D(_MainTex, i.uv);
                //return col;		
                return _Color;		
            }

            ENDCG
        }
    }
}