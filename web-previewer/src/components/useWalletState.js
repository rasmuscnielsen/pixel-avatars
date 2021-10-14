import {computed, ref, reactive} from 'vue'

export default function useWalletState() {
    const address = ref(null)
    const tokens = ref(null)
    const isConnected = computed(() => address.value !== null)

    return {
        address,
        isConnected,
        tokens,

        connect() {
            address.value = '0xasdasoiqwejq12312wdiqwd'
            tokens.value = [123, 234, 345, 456]
        },

        disconnect() {
            address.value = null
            tokens.value = []
        },

        claim(token) {

        }
    }
}