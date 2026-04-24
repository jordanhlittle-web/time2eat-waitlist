-- Run this in Supabase SQL Editor: https://supabase.com/dashboard/project/edazhagjfdpfvbygpqnq/sql

CREATE TABLE IF NOT EXISTS share_clicks (
  id          uuid        DEFAULT gen_random_uuid() PRIMARY KEY,
  email       text,                          -- the email of the person who shared (if captured)
  share_type  text        NOT NULL,          -- 'whatsapp' | 'instagram' | 'copy_link'
  created_at  timestamptz DEFAULT now()
);

-- Allow the anon key to insert (same as the waitlist table)
ALTER TABLE share_clicks ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Allow anon inserts" ON share_clicks
  FOR INSERT TO anon WITH CHECK (true);

-- Optional: allow you to read all rows from the dashboard
CREATE POLICY "Allow service role reads" ON share_clicks
  FOR SELECT TO service_role USING (true);
