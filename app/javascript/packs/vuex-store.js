const state = {
  count: 0,
  token: null,
};
const mutations = {
  increment(state) {
    state.count++;
  },
  setToken(state, token) {
    state.token = token;
  },
};

export { state, mutations };
