# setup_extra_paths.sh

CONFY_DIR="/opt/ComfyUI"
YAML_FILE="$CONFY_DIR/extra_model_paths.yaml"
MODEL_DIR="$HOME/comfy-models"

mkdir -p "$MODEL_DIR"/{text_encoders,vae,diffusion_models,loras}

cat > "$YAML_FILE" <<EOF
comfyui:
    base_path: $MODEL_DIR

    audio_encoders: audio_encoders
    checkpoints: checkpoints
    clip: clip
    clip_vision: clip_vision
    configs: configs
    controlnet: controlnet
    diffusers: diffusers
    diffusion_models: diffusion_models
    embeddings: embeddings
    gligen: gligen
    hypernetworks: hypernetworks
    latent_upscale_models: latent_upscale_models
    loras: loras
    model_patches: model_patches
    photomaker: photomaker
    qwen-tts: qwen-tts
    style_models: style_models
    text_encoders: text_encoders
    unet: unet
    upscale_models: upscale_models
    vae: vae
    vae_approx: vae_approx
EOF

echo "✅ Wrote $YAML_FILE"
