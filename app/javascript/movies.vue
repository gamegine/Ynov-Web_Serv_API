<template>
  <div>
    <div class="container">
      <div class="row">
        <article class="col-md-4" v-for="item in json" :key="item.id">
          <div class="card mb-4 shadow-sm">
            <svg width="100%" height="225">
              <rect width="100%" height="100%" fill="#55595c" />
              <text x="50%" y="50%" fill="#eceeef" dy=".3em">
                {{ item.title }}
              </text>
            </svg>
            <div class="card-body">
              <div class="d-flex justify-content-between align-items-center">
                <div class="btn-group">
                  <button
                    class="btn btn-sm btn-outline-secondary"
                    v-on:click="showMovie(item)"
                  >
                    View
                  </button>
                  <button
                    class="btn btn-sm btn-outline-secondary"
                    v-on:click="showEditMovie(item)"
                  >
                    Edit
                  </button>
                  <button
                    class="btn btn-sm btn-outline-secondary"
                    v-on:click="deleteMovie(item)"
                  >
                    Delete
                  </button>
                </div>
              </div>
            </div>
          </div>
        </article>
      </div>
      <br />
      <div class="row">
        <button class="col" v-on:click="page -= 1">previous</button>
        <button class="col" v-on:click="page += 1">next</button>
      </div>
    </div>
    <button class="col" v-on:click="showNewMovie">New</button>
  </div>
</template>

<script>
import axios from "axios";
import { mapState } from "vuex";

import movie from "movie";
import movieform from "movieform";

export default {
  name: "movies",
  data() {
    return {
      json: {},
      page: 1,
    };
  },
  computed: {
    ...mapState(["token"]),
  },
  methods: {
    async getMovies() {
      const res = await axios(`/api/v1/movies?page=${this.page}&per_page=3`);
      this.json = res.data;
    },
    async createMovie(item) {
      const url = `/api/v1/movies?access_token=${this.token}`;
      const res = await axios({ method: "post", url, data: { movie: item } });
      res.status == 201 && (await this.getMovies()); // refresh local
    },
    async update(item) {
      const url = `/api/v1/movies/${item.id}?access_token=${this.token}`;
      const res = await axios({ method: "put", url, data: { movie: item } });
      res.status == 200 && (await this.getMovies()); // refresh local
    },
    async deleteMovie(item) {
      const url = `/api/v1/movies/${item.id}?access_token=${this.token}`;
      const res = await axios({ method: "delete", url });
      res.status == 204 && (await this.getMovies()); // refresh local
    },
    showMovie(item) {
      this.$modal.show(
        movie,
        { movie: item, edit: () => this.showEditMovie(item, this.update) },
        { height: "auto" }
      );
    },
    showEditMovie(item, update) {
      this.$modal.show(
        movieform,
        { movie: item, submit: update || this.update },
        { height: "auto" }
      );
    },
    showNewMovie() {
      this.$modal.show(movieform, {
        movie: { title: "" },
        submit: this.createMovie,
      });
    },
  },
  watch: {
    page: {
      immediate: true,
      handler(newVal, oldVal) {
        this.getMovies();
      },
    },
  },
};
</script>
