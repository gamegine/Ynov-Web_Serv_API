<template>
  <div v-if="!loadig" class="card shadow-sm">
    <svg width="100%" height="225">
      <title>Placeholder</title>
      <rect width="100%" height="100%" fill="#55595c" />
      <text x="50%" y="50%" fill="#eceeef" dy=".3em">Thumbnail</text>
    </svg>
    <div class="card-body">
      <p class="card-text">
        This is a wider card with supporting text below as a natural lead-in to
        additional content. This content is a little bit longer.
      </p>
      <div class="d-flex justify-content-between align-items-center">
        <div class="btn-group">
          <button class="btn btn-sm btn-outline-secondary" v-on:click="edit">
            Edit
          </button>
        </div>
        <small class="text-muted">9 mins</small>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "movie",
  props: ["movie", "edit"],
  data() {
    return {
      loadig: false,
    };
  },
  watch: {
    movie: {
      immediate: true,
      handler(newVal, oldVal) {
        //console.log("Prop changed: ", newVal, " | was: ", oldVal);
        // `http://localhost:3000/api/v1/watches`
      },
    },
  },
};
</script>
