import bcrypt from 'bcrypt';

const run = async () => {
  const passwordPlano = 'Frijol001.';

  const hash = await bcrypt.hash(passwordPlano, 10);

  console.log('HASH:', hash);
};

run();