-- ============================================================
-- Brave Agency CMS - Supabase Setup
-- Paste this entire file in the Supabase SQL Editor and run it
-- ============================================================

-- ============================================================
-- TABLES
-- ============================================================

create table if not exists portfolio_projects (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  category text not null,
  description text,
  image_url text,
  live_url text,
  challenge text,
  solution text,
  result text,
  sort_order int default 0,
  visible boolean default true,
  created_at timestamptz default now()
);

create table if not exists team_members (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  role text,
  photo_url text,
  description text,
  sort_order int default 0,
  visible boolean default true
);

create table if not exists metrics (
  id uuid primary key default gen_random_uuid(),
  label text not null,
  value text not null,
  sort_order int default 0
);

-- ============================================================
-- ROW LEVEL SECURITY
-- ============================================================

alter table portfolio_projects enable row level security;
alter table team_members enable row level security;
alter table metrics enable row level security;

-- portfolio_projects
create policy "Public read portfolio_projects"
  on portfolio_projects for select
  using (true);

create policy "Authenticated write portfolio_projects"
  on portfolio_projects for insert
  with check (auth.role() = 'authenticated');

create policy "Authenticated update portfolio_projects"
  on portfolio_projects for update
  using (auth.role() = 'authenticated');

create policy "Authenticated delete portfolio_projects"
  on portfolio_projects for delete
  using (auth.role() = 'authenticated');

-- team_members
create policy "Public read team_members"
  on team_members for select
  using (true);

create policy "Authenticated write team_members"
  on team_members for insert
  with check (auth.role() = 'authenticated');

create policy "Authenticated update team_members"
  on team_members for update
  using (auth.role() = 'authenticated');

create policy "Authenticated delete team_members"
  on team_members for delete
  using (auth.role() = 'authenticated');

-- metrics
create policy "Public read metrics"
  on metrics for select
  using (true);

create policy "Authenticated write metrics"
  on metrics for insert
  with check (auth.role() = 'authenticated');

create policy "Authenticated update metrics"
  on metrics for update
  using (auth.role() = 'authenticated');

create policy "Authenticated delete metrics"
  on metrics for delete
  using (auth.role() = 'authenticated');

-- ============================================================
-- STORAGE BUCKETS
-- ============================================================

insert into storage.buckets (id, name, public)
values ('portfolio-images', 'portfolio-images', true)
on conflict (id) do nothing;

insert into storage.buckets (id, name, public)
values ('team-photos', 'team-photos', true)
on conflict (id) do nothing;

-- Storage policies: portfolio-images
create policy "Public read portfolio-images"
  on storage.objects for select
  using (bucket_id = 'portfolio-images');

create policy "Authenticated upload portfolio-images"
  on storage.objects for insert
  with check (bucket_id = 'portfolio-images' and auth.role() = 'authenticated');

create policy "Authenticated update portfolio-images"
  on storage.objects for update
  using (bucket_id = 'portfolio-images' and auth.role() = 'authenticated');

create policy "Authenticated delete portfolio-images"
  on storage.objects for delete
  using (bucket_id = 'portfolio-images' and auth.role() = 'authenticated');

-- Storage policies: team-photos
create policy "Public read team-photos"
  on storage.objects for select
  using (bucket_id = 'team-photos');

create policy "Authenticated upload team-photos"
  on storage.objects for insert
  with check (bucket_id = 'team-photos' and auth.role() = 'authenticated');

create policy "Authenticated update team-photos"
  on storage.objects for update
  using (bucket_id = 'team-photos' and auth.role() = 'authenticated');

create policy "Authenticated delete team-photos"
  on storage.objects for delete
  using (bucket_id = 'team-photos' and auth.role() = 'authenticated');

-- ============================================================
-- SEED DATA
-- ============================================================

insert into portfolio_projects (title, category, description, image_url, live_url, challenge, solution, result, sort_order, visible)
values
(
  'Fat Drive Factory',
  'Website',
  'Presença digital com identidade forte e conversão mobile-first.',
  'img/portfolio/screencapture-fatdrivefactory-br-2026-04-07-09_56_58.png',
  'https://fatdrivefactory.com.br',
  'Criar uma presença digital que comunica a identidade forte e irreverente da marca, mantendo alta performance e conversão.',
  'Site one-page com hierarquia visual agressiva, tipografia display e CTA otimizado para conversão mobile-first.',
  '+240% de aumento em sessões orgânicas no primeiro mês após o lançamento.',
  1,
  true
),
(
  'RF1 Consig',
  'Sistema Web / Simulador',
  'Simulador de crédito consignado com conversão 3x superior à média.',
  'img/portfolio/screencapture-nelsonvieiramartins-github-io-rf1consig-preview-index-html-2026-04-07-11_05_36.png',
  'https://nelsonvieiramartins.github.io/rf1consig/preview/index.html',
  'Desenvolver um simulador de crédito consignado intuitivo, que transmite confiança e converte visitantes em leads qualificados.',
  'Interface limpa com simulador interativo em destaque, fluxo simplificado e design que transmite credibilidade financeira.',
  'Taxa de conversão de leads 3x superior à média do segmento.',
  2,
  true
);

insert into team_members (name, role, photo_url, description, sort_order, visible)
values
(
  'Nelson Vieira Martins',
  'Diretor de Artes, Web Design & Engenharia de I.A.',
  'img/quemsomos/nelsonvieiramartins.webp',
  'Unindo inteligência artificial ao design para criar experiências digitais de alto impacto.',
  1,
  true
),
(
  'Piero Brito',
  'Dev Master & Especialista em Logística de Dados',
  'img/quemsomos/pierobrito.jpeg',
  'Arquiteto de sistemas robustos que suportam grandes volumes com performance e precisão.',
  2,
  true
),
(
  'Thiago Fagundes',
  'Especialista em Marketing Digital & Planejamento Estratégico',
  'img/quemsomos/thiagofaguntes.jpeg',
  'Estratégias digitais orientadas a dados que conectam marcas ao público certo no momento certo.',
  3,
  true
);

insert into metrics (label, value, sort_order)
values
  ('Clientes Satisfeitos', '1000+', 1),
  ('Projetos Entregues', '200+', 2),
  ('Anos de Experiência', '8+', 3);
