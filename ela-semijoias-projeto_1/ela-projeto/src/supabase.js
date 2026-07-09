import { createClient } from "@supabase/supabase-js";

// Estas duas informações vêm do painel do Supabase (Settings > API).
// No ambiente da Vercel elas são lidas das "Environment Variables"
// (veja o GUIA-PASSO-A-PASSO.md).
const supabaseUrl = import.meta.env.VITE_SUPABASE_URL;
const supabaseAnonKey = import.meta.env.VITE_SUPABASE_ANON_KEY;

export const supabase = createClient(supabaseUrl, supabaseAnonKey);

// Nome do "bucket" (pasta) de imagens no Supabase Storage.
export const BUCKET_FOTOS = "produtos";
