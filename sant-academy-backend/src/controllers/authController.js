const dbService = require("../services/databaseService");
const authService = require("../services/authService");

class Auth {
  async createUser(request, response) {
    // Check if the user has an username
    if (!request.body.username) return response.status(403);

    const newUser = await dbService.createUser(user);
    // Assure that the user was creared
    if (!newUser) return response.status(403);

    console.log(newUser);
    // Creating access token for the new user
    const token = authService.createToken({
      id: newUser._id,
      username: newUser.username
    })
    
    return response
      .status(201)
      .json({
        user: newUser,
        accessToken: token
      })
  }

  async testApi(request, response) {
    // Check if the user has an username
    if (!request.body.username) return response.status(403);

    const queryUser = await dbService.getUser(user.username);

    return response
      .status(200)
      .json({
        queryUser
      })
  }
}

module.exports = new Auth();