#pragma once

#include "D3DClass.h"
#include "CameraClass.h"
#include "ModelClass.h"
#include "ShaderClass.h"
#include "TextureClass.h"
#include <PrimitiveBatch.h>
#include <vector>
#include "LightClass.h"

const bool FULL_SCREEN = false;
const bool VSYNC_ENABLED = true;
const float SCREEN_DEPTH = 1000.0f;
const float SCREEN_NEAR = 0.1f;

class GraphicsClass
{
public:
	GraphicsClass();
	GraphicsClass(const GraphicsClass&);
	~GraphicsClass();

	bool Initialize(int, int, HWND);
	void Shutdown();
	bool Frame(InputClass*);

private:
	bool Render(float, InputClass*);
	void CheckWireframe(InputClass*);
	void ChangeFillmode(D3D11_FILL_MODE);
	ModelClass* InitializeModel(HWND, char*, WCHAR*, XMFLOAT3, float);
	void ShutdownModels();

	D3DClass* direct3D;
	CameraClass* camera;
	std::vector<ModelClass*> models;
	ShaderClass* shader;
	HWND* hwndptr;
	LightClass* light;

	bool wireframeMode, wireframeKeyToggle;

};