module.exports = function(db, DataTypes) {
  return db.define('user', {
    id: { type: DataTypes.INTEGER(10), primaryKey: true, autoIncrement: true },
    email: { type: DataTypes.STRING(255), unique: true, index: true },
    password: { type: DataTypes.STRING(255), unique: false, index: true }, 

  }, {
    timestamps: false,
    tableName: 'user'
  });
};