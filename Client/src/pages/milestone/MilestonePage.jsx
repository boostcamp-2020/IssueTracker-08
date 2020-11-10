import React from 'react';
import Container from '../../components/shared/container/Container';
import ItemContainer from '../../components/shared/container/ItemContainer';
import ItemHeader from '../../components/shared/container/ItemHeader';
import Menu from '../../components/shared/container/Menu';

export default function MilestonePage() {
  return (
    <Container>
      <Menu link="/milestone/post" name="milestone"></Menu>
      <ItemContainer>
        <ItemHeader></ItemHeader>
      </ItemContainer>
    </Container>
  );
}
