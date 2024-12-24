// server/auth.js

const validateUser = (user) => {
    if (!user || typeof user.username !== 'string' || typeof user.password !== 'string') {
      return false;
    }
    // Verifica que el username y password no estén vacíos
    return user.username.trim() !== '' && user.password.trim() !== '';
  };
  
  module.exports = {
    validateUser,
  };
  