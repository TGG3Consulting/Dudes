create table if not exists public.locations (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  address text not null,
  city text not null default 'Ереван',
  phone text,
  working_hours jsonb default '{"mon_fri": "10:00-21:00", "sat": "10:00-21:00", "sun": "11:00-20:00"}'::jsonb,
  photo_url text,
  altegio_branch_id bigint,
  is_active boolean not null default true,
  sort_order int not null default 0,
  created_at timestamptz not null default now()
);

alter table public.locations enable row level security;

create policy "Locations are viewable by everyone"
  on public.locations for select
  using (true);

-- Seed data: 4 салона
insert into public.locations (name, address, city, phone, sort_order) values
  ('Dude''s Barber — Центр',   'ул. Абовяна 22, Ереван',    'Ереван', '+374 10 123456', 1),
  ('Dude''s Barber — Малатия', 'пр. Маштоца 50, Ереван',    'Ереван', '+374 10 654321', 2),
  ('Dude''s Barber — Пушкина', 'ул. Пушкина 31, Ереван',    'Ереван', '+374 10 111111', 3),
  ('Dude''s Barber — Комитас', 'пр. Комитаса, Ереван',      'Ереван', '+374 10 222222', 4);
