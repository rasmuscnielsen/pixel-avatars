export const CURRENCY_SYMBOL = 'MATIC'
export const INFURA_ID = process.env.VUE_APP_INFURA_ID
export const OPEN_SEA_URL = process.env.VUE_APP_OPEN_SEA_URL
export const PIXEL_AVATAR_TOKEN = process.env.VUE_APP_PIXEL_AVATAR_TOKEN
export const PIXEL_AVATAR_NETWORK = {
    name: process.env.VUE_APP_PIXEL_AVATAR_NETWORK_NAME,
    chainId: parseInt(process.env.VUE_APP_PIXEL_AVATAR_NETWORK_CHAIN_ID),
    ensAddress: process.env.VUE_APP_PIXEL_AVATAR_NETWORK_RPC,
}

export const SERVER_URL = process.env.VUE_APP_SERVER_URL
