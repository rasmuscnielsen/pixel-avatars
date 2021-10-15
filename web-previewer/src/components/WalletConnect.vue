<script setup>
const props = defineProps({
    state: Object
})
</script>

<template>
    <button
        class="bg-black text-white text-sm py-2 rounded px-4 inline-block"
        v-if="! state.isConnected.value"
        @click="state.connect()"
    >
        Connect wallet
    </button>

    <div class="flex-1 min-w-0 flex flex-col items-end space-y-1" v-else>
        <span class="text-sm text-gray-500">Connected to</span>
        <div>
            <span class="text-sm font-semibold truncate" v-text="state.address.value.substr(0, 20) + '...'" />
        </div>
        <button class="text-sm inline text-blue-500" @click="state.disconnect()">
            Disconnect
        </button>
    </div>
</template>