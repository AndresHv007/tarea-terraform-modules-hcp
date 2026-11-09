export default {
  async fetch(request, env) {
    if (request.method !== "GET") {
      return Response.json(
        { error: "Método no permitido. Usa GET." },
        { status: 405 }
      );
    }

    let d1Connected = false;
    if (env.DB) {
      try {
        const dbResult = await env.DB.prepare("SELECT 1 AS ok").first();
        d1Connected = dbResult?.ok === 1;
      } catch (err) {
        d1Connected = false;
      }
    }

    return Response.json({
      method: "GET",
      status: "ok",
      message: "Respuesta GET desde Cloudflare Worker modular desplegado con Terraform y HCP",
      d1_connected: d1Connected,
    });
  },
};
