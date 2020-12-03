<template>
  <div>
    <div class="form-group">
      <label for="title">Title</label>
      <input id="title" type="text" class="form-control" v-model="form.title" />
    </div>
    <div class="row">
      <button class="col btn-primary" v-on:click="post">Submit</button>
      <button class="col btn" @click="$emit('close')">cancel</button>
    </div>
  </div>
</template>

<script>
export default {
  name: "movie",
  props: ["movie", "submit"],
  data() {
    return {
      loadig: false,
      form: { title: "test" },
    };
  },
  methods: {
    post() {
      this.submit(this.form);
      this.$emit("close");
    },
  },
  watch: {
    movie: {
      immediate: true,
      handler(newVal, oldVal) {
        this.form = { ...newVal };
      },
    },
  },
};
</script>
