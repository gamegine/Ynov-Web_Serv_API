<template>
  <div id="app">
    token : {{ token }}
    <br />
    <br />
    <movies />
  </div>
</template>

<script>
import movies from "movies.vue";
import axios from "axios";
import { mapState } from "vuex";
export default {
  components: {
    movies,
  },
  data() {
    return { oauth_token_url: "", token: "" };
  },
  mounted() {
    console.log("mounted");
    console.log(this.count);
    const urlParam = new URLSearchParams(window.location.search).get("code"); // utl?code=---
    if (urlParam) {
      this.oauth_token_authorization().then((res) => {
        localStorage.setItem("token", res.data.access_token);
      }, console.error);
    }
    this.token = localStorage.getItem("token");
    this.$store.commit("setToken", this.token);
  },
  methods: {
    async oauth_token_authorization() {
      return axios({
        method: "post",
        url: document.getElementById("oauth_token_url").innerHTML,
      });
    },
    deletetoken() {
      localStorage.setItem("token", res.data.access_token);
      this.token = "";
    },
  },
  computed: {
    ...mapState(["count"]),
    url() {
      return window.location;
    },
  },
  watch: {
    url: {
      immediate: true,
      handler(newVal, oldVal) {
        console.log("Prop changed: ", newVal, " | was: ", oldVal);
      },
    },
  },
};
</script>
