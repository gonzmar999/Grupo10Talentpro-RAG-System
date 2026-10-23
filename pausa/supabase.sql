-- Pausa: base de datos para las cuentas.
-- Pegá todo este archivo en Supabase → SQL Editor → New query, y tocá "Run".
-- Se puede correr más de una vez sin problema.

-- Una fila por persona, con todos sus datos de Pausa.
create table if not exists public.pausa_data (
  user_id    uuid primary key references auth.users(id) on delete cascade,
  data       jsonb not null,
  updated_at timestamptz not null default now()
);

-- Cada cuenta solo puede leer y escribir su propia fila.
alter table public.pausa_data enable row level security;

drop policy if exists "leer mis datos" on public.pausa_data;
create policy "leer mis datos" on public.pausa_data
  for select using (auth.uid() = user_id);

drop policy if exists "crear mis datos" on public.pausa_data;
create policy "crear mis datos" on public.pausa_data
  for insert with check (auth.uid() = user_id);

drop policy if exists "actualizar mis datos" on public.pausa_data;
create policy "actualizar mis datos" on public.pausa_data
  for update using (auth.uid() = user_id) with check (auth.uid() = user_id);

drop policy if exists "borrar mis datos" on public.pausa_data;
create policy "borrar mis datos" on public.pausa_data
  for delete using (auth.uid() = user_id);

-- Permite que cada persona elimine su propia cuenta desde la app.
create or replace function public.delete_user()
returns void
language sql
security definer
set search_path = public
as $$
  delete from auth.users where id = auth.uid();
$$;

revoke all on function public.delete_user() from public, anon;
grant execute on function public.delete_user() to authenticated;
