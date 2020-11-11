import React from 'react';
import LabelStore from '../../stores/LabelStore';
import Container from '../../components/shared/container/Container';
import ItemContainer from '../../components/shared/container/ItemContainer';
import ItemHeader from '../../components/shared/container/ItemHeader';
import LabelMenu from '../../components/label/LabelMenu';
import LabelTitle from '../../components/label/LabelTitle';
import LabelList from '../../components/label/LabelList';

export default function LabelPage() {
  return (
    <LabelStore>
      <Container>
        <LabelMenu />
        <ItemContainer>
          <ItemHeader>
            <LabelTitle />
          </ItemHeader>
          <LabelList />
        </ItemContainer>
      </Container>
    </LabelStore>
  );
}
