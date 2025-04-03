//
//  Supabase.swift
//  BillMinder
//
//  Created by Gabriel on 01/04/25.
//

import Foundation
import Supabase

let supabaseClient = SupabaseClient(
    supabaseURL: URL(string: Env.SUPABASE_URL)!,
    supabaseKey: Env.SUPABASE_APIKEY
)

var supabaseStorageClient: SupabaseStorageClient {
    return supabaseClient.storage
}
