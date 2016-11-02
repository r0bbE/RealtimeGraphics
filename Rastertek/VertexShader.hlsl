cbuffer MatrixBuffer
{
    matrix worldMatrix;
    matrix viewMatrix;
    matrix projectionMatrix;
    matrix lightViewMatrix;
    matrix lightProjectionMatrix;
    matrix lightViewMatrix2;
    matrix lightProjectionMatrix2;
};

cbuffer LightBuffer2
{
    float3 lightPosition;
    float padding1;
    float3 lightPosition2;
    float padding2;
};

struct VertexInputType
{
    float4 position : POSITION;
    float2 tex : TEXCOORD0;
    float3 instancePosition : TEXCOORD1;
    float3 normal : NORMAL;
};

struct PixelInputType
{
    float4 position : SV_Position;
    float2 tex : TEXCOORD0;
    float3 normal : NORMAL;
    float4 lightViewPosition : TEXCOORD2;
    float3 lightPos : TEXCOORD3;
    float4 lightViewPosition2 : TEXCOORD4;
    float3 lightPos2 : TEXCOORD5;
};

PixelInputType main( VertexInputType input )
{
    PixelInputType output;
    float4 worldPosition;

    //Hardcoded
    input.position.w = 1.0f;

    //Calculate final position of vertex
    worldPosition = mul(input.position, worldMatrix);
    output.position = mul(worldPosition, viewMatrix);
    output.position = mul(output.position, projectionMatrix);

    //Calculate vertexposition from light viewpoint
    output.lightViewPosition = mul(input.position, worldMatrix);
    output.lightViewPosition = mul(output.lightViewPosition, lightViewMatrix);
    output.lightViewPosition = mul(output.lightViewPosition, lightProjectionMatrix);
    //Calculate vertexposition from second light viewpoint
    output.lightViewPosition2 = mul(input.position, worldMatrix);
    output.lightViewPosition2 = mul(output.lightViewPosition2, lightViewMatrix2);
    output.lightViewPosition2 = mul(output.lightViewPosition2, lightProjectionMatrix2);

    //Texture coordinates
    output.tex = input.tex;

    //Diffuse Light - World Related
    output.normal = mul(input.normal, (float3x3) worldMatrix);
    output.normal = normalize(output.normal);

    //Determine Light Position
    output.lightPos = lightPosition.xyz - worldPosition.xyz;
    output.lightPos = normalize(output.lightPos);

    //Determine Light 2 Position
    output.lightPos2 = lightPosition2.xyz - worldPosition.xyz;
    output.lightPos2 = normalize(output.lightPos2);

    return output;
}