-- 15º BAEP Virtual JR3 — migração complementar e conservadora
-- Não apaga registros nem modifica políticas das tabelas existentes.
-- Execute no Supabase SQL Editor. Pode ser executado novamente.

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

-- Criar políticas apenas se ainda não existirem; nenhuma política existente é removida.
do $$
begin
  if not exists (select 1 from pg_policies where schemaname='public' and tablename='turnos' and policyname='turnos leitura publica') then
    create policy "turnos leitura publica" on public.turnos
      for select to anon, authenticated using (true);
  end if;
  if not exists (select 1 from pg_policies where schemaname='public' and tablename='turnos' and policyname='turnos admin inserir') then
    create policy "turnos admin inserir" on public.turnos
      for insert to authenticated with check (public.is_baep_admin());
  end if;
  if not exists (select 1 from pg_policies where schemaname='public' and tablename='turnos' and policyname='turnos admin atualizar') then
    create policy "turnos admin atualizar" on public.turnos
      for update to authenticated using (public.is_baep_admin()) with check (public.is_baep_admin());
  end if;
  if not exists (select 1 from pg_policies where schemaname='public' and tablename='turnos' and policyname='turnos admin excluir') then
    create policy "turnos admin excluir" on public.turnos
      for delete to authenticated using (public.is_baep_admin());
  end if;
end $$;
