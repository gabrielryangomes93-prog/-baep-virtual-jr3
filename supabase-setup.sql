-- 15º BAEP Virtual JR3 — completar estrutura do banco
-- Execute uma única vez no Supabase > SQL Editor > New query.
-- Não apaga os registros existentes.

alter table public.ocorrencias
  add column if not exists horario text,
  add column if not exists equipe text,
  add column if not exists viatura text,
  add column if not exists resultado text,
  add column if not exists responsavel text;

alter table public.operacoes
  add column if not exists horario text,
  add column if not exists equipe text,
  add column if not exists responsavel text,
  add column if not exists situacao text default 'Planejada';

alter table public.efetivo
  add column if not exists funcao text,
  add column if not exists situacao text default 'Ativo',
  add column if not exists observacoes text;

create table if not exists public.turnos (
  id uuid primary key default gen_random_uuid(),
  titulo text not null,
  data_turno date,
  inicio text,
  termino text,
  responsavel text,
  equipe text,
  situacao text not null default 'Programado',
  criado_em timestamptz not null default now()
);

alter table public.turnos enable row level security;

-- Conteúdo de roleplay pode ser consultado publicamente; só administradores alteram.
drop policy if exists "turnos leitura publica" on public.turnos;
create policy "turnos leitura publica" on public.turnos
  for select to anon, authenticated using (true);

drop policy if exists "turnos admin inserir" on public.turnos;
create policy "turnos admin inserir" on public.turnos
  for insert to authenticated with check (public.is_baep_admin());

drop policy if exists "turnos admin atualizar" on public.turnos;
create policy "turnos admin atualizar" on public.turnos
  for update to authenticated using (public.is_baep_admin()) with check (public.is_baep_admin());

drop policy if exists "turnos admin excluir" on public.turnos;
create policy "turnos admin excluir" on public.turnos
  for delete to authenticated using (public.is_baep_admin());

-- Garantir acesso de leitura aos registros do portal.
alter table public.ocorrencias enable row level security;
alter table public.operacoes enable row level security;
alter table public.efetivo enable row level security;

drop policy if exists "ocorrencias leitura publica" on public.ocorrencias;
create policy "ocorrencias leitura publica" on public.ocorrencias
  for select to anon, authenticated using (true);
drop policy if exists "ocorrencias admin inserir" on public.ocorrencias;
create policy "ocorrencias admin inserir" on public.ocorrencias
  for insert to authenticated with check (public.is_baep_admin());
drop policy if exists "ocorrencias admin atualizar" on public.ocorrencias;
create policy "ocorrencias admin atualizar" on public.ocorrencias
  for update to authenticated using (public.is_baep_admin()) with check (public.is_baep_admin());
drop policy if exists "ocorrencias admin excluir" on public.ocorrencias;
create policy "ocorrencias admin excluir" on public.ocorrencias
  for delete to authenticated using (public.is_baep_admin());

drop policy if exists "operacoes leitura publica" on public.operacoes;
create policy "operacoes leitura publica" on public.operacoes
  for select to anon, authenticated using (true);
drop policy if exists "operacoes admin inserir" on public.operacoes;
create policy "operacoes admin inserir" on public.operacoes
  for insert to authenticated with check (public.is_baep_admin());
drop policy if exists "operacoes admin atualizar" on public.operacoes;
create policy "operacoes admin atualizar" on public.operacoes
  for update to authenticated using (public.is_baep_admin()) with check (public.is_baep_admin());
drop policy if exists "operacoes admin excluir" on public.operacoes;
create policy "operacoes admin excluir" on public.operacoes
  for delete to authenticated using (public.is_baep_admin());

drop policy if exists "efetivo leitura publica" on public.efetivo;
create policy "efetivo leitura publica" on public.efetivo
  for select to anon, authenticated using (true);
drop policy if exists "efetivo admin inserir" on public.efetivo;
create policy "efetivo admin inserir" on public.efetivo
  for insert to authenticated with check (public.is_baep_admin());
drop policy if exists "efetivo admin atualizar" on public.efetivo;
create policy "efetivo admin atualizar" on public.efetivo
  for update to authenticated using (public.is_baep_admin()) with check (public.is_baep_admin());
drop policy if exists "efetivo admin excluir" on public.efetivo;
create policy "efetivo admin excluir" on public.efetivo
  for delete to authenticated using (public.is_baep_admin());
