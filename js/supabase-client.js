import { createClient } from 'https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2/dist/esm/index.js';

const SUPABASE_URL = 'https://momopryksxaenfwhzrcn.supabase.co';
const SUPABASE_KEY = 'sb_publishable_0R07eDLCRMSn5BUFmFstxQ_Nybv7qMe';

export const supabase = createClient(SUPABASE_URL, SUPABASE_KEY);
