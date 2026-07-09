-- ============================================================
-- ELA SEMIJOIAS — CRIAÇÃO DO BANCO DE DADOS
-- ============================================================
-- Como usar: no Supabase, vá em "SQL Editor" (menu lateral),
-- cole TODO este conteúdo e clique em "Run".
-- ============================================================

-- 1) Tabela de produtos
create table if not exists produtos (
  id uuid primary key default gen_random_uuid(),
  nome text not null,
  preco numeric not null,
  categoria text,
  descricao text,
  destaque boolean default false,
  foto text,
  criado_em timestamptz default now()
);

-- 2) Segurança (RLS): permite que o site LEIA os produtos,
--    e que o painel INSIRA/EDITE/REMOVA.
--    (Como a loja é simples e a senha do painel é do lado do site,
--     liberamos as operações via chave pública. Se quiser algo mais
--     protegido no futuro, dá para adicionar login de verdade.)
alter table produtos enable row level security;

create policy "leitura publica"
  on produtos for select
  using (true);

create policy "escrita publica"
  on produtos for insert
  with check (true);

create policy "edicao publica"
  on produtos for update
  using (true);

create policy "remocao publica"
  on produtos for delete
  using (true);

-- 3) Produtos de exemplo (pode apagar depois pelo painel)
insert into produtos (nome, preco, categoria, descricao, destaque, foto) values
('Colar Ponto de Luz', 89.90, 'Colares', 'Banho de ouro 18k, zircônia central. Corrente 45cm.', true, 'https://images.unsplash.com/photo-1599643478518-a784e5dc4c8f?w=600&q=80'),
('Brinco Argola Média', 54.90, 'Brincos', 'Banho de ouro 18k, acabamento polido. Fecho de pressão.', true, 'https://images.unsplash.com/photo-1635767798638-3e25273a8236?w=600&q=80'),
('Anel Solitário', 69.90, 'Anéis', 'Banho de ouro 18k com zircônia cristal. Ajustável.', true, 'https://images.unsplash.com/photo-1605100804763-247f67b3557e?w=600&q=80'),
('Pulseira Elos', 74.90, 'Pulseiras', 'Banho de ouro 18k, elos entrelaçados. 19cm com extensor.', false, 'https://images.unsplash.com/photo-1611652022419-a9419f74343d?w=600&q=80');

-- ============================================================
-- IMPORTANTE — STORAGE (fotos): não dá para criar por SQL aqui.
-- Siga o passo do guia: criar um "bucket" público chamado "produtos".
-- ============================================================
