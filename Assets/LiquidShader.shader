Shader "Unlit/LiquidShader"
{
    Properties
    {
        _CorParticula("Cor Particula", Color) = (1,1,1,1)
        _AlphaExcluido ("Alpha cutoff", Range(0, 1)) = 0.5
    }
    SubShader
    {
        Tags { "Queue" = "Transparent" }
        Blend SrcAlpha OneMinusSrcAlpha

        GrabPass   {
            "_TexturaDeFundo"
        }
        Lighting off
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float4 grabPos : TEXCOORD0;
                float4 vertex : SV_POSITION;
                float2 alphaUV : TEXCOORD1;
            };

            sampler2D _TexturaDeFundo;
            float _TexturaDeFundo_ST;
            half4 _CorParticula;
            fixed _AlphaExcluido;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.grabPos = ComputeGrabScreenPos(o.vertex);
                //o.alphaUV = TRANSFORM_TEX(v.uv, _TexturaDeFundo);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                half4 bgColor = tex2Dproj(_TexturaDeFundo, i.grabPos);
                if (bgColor.a < _AlphaExcluido)   {
                    clip(bgColor.a - _AlphaExcluido);
                }else   {
                    bgColor = _CorParticula;
                }
                return bgColor;
            }
            ENDCG
        }
    }
}
