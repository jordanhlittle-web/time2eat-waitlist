-- Time2Eat Waitlist Table
-- Run this in your Supabase SQL editor (supabase.com → SQL Editor)

create table if not exists public.waitlist (
  id         uuid primary key default gen_random_uuid(),
  email      text not null unique,
  in_bali    boolean not null default false,
  created_at timestamptz not null default now()
);

-- Allow public inserts (no auth required for waitlist signups)
alter table public.waitlist enable row level security;

create policy "Anyone can join the waitlist"
  on public.waitlist
  for insert
  to anon
  with check (true);

-- Optional: let authenticated admins read all rows
create policy "Admins can read waitlist"
  on public.waitlist
  for select
  to authenticated
  using (true);
