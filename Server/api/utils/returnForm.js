module.exports = {
  failResponse(message) {
    return {
      status: 'fail',
      data: message,
    };
  },

  successResponse(data) {
    return {
      status: 'success',
      data: data,
    };
  },
};
