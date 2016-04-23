--森羅の鎮神 オレイア
function c501001050.initial_effect(c)
        --xyz summon
        aux.AddXyzProcedure(c,aux.XyzFilterFunction(c,7),2)
        c:EnableReviveLimit()
        --announce
        local e1=Effect.CreateEffect(c)
        e1:SetDescription(aux.Stringid(501001050,0))
        e1:SetType(EFFECT_TYPE_IGNITION)
        e1:SetRange(LOCATION_MZONE)
        e1:SetCountLimit(1)
        e1:SetCost(c501001050.cost)
        e1:SetTarget(c501001050.target)
        e1:SetOperation(c501001050.operation)
        c:RegisterEffect(e1)
        --deck
        local e2=Effect.CreateEffect(c)
        e2:SetDescription(aux.Stringid(501001050,2))
        e2:SetCategory(CATEGORY_TOGRAVE)
        e2:SetType(EFFECT_TYPE_IGNITION)
        e2:SetCountLimit(1)
        e2:SetRange(LOCATION_MZONE)
        e2:SetCost(c501001050.tdcost)
        e2:SetTarget(c501001050.tdtarget)
        e2:SetOperation(c501001050.tdoperation)
        c:RegisterEffect(e2)
end
function c501001050.cfilter(c)
   return c:IsRace(RACE_PLANT) and (c:IsLocation(LOCATION_HAND) or c:IsFaceup()) and c:IsAbleToGraveAsCost()
end
function c501001050.cost(e,tp,eg,ep,ev,re,r,rp,chk)
   if chk==0 then return Duel.IsExistingMatchingCard(c501001050.cfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,nil) end
   Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
   local g=Duel.SelectMatchingCard(tp,c501001050.cfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,1,nil)
   if g:GetFirst():GetLevel()>0 then e:SetLabel(g:GetFirst():GetLevel()) end
   Duel.SendtoGrave(g,REASON_COST)
end
function c501001050.target(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>e:GetLabel() end
end
function c501001050.operation(e,tp,eg,ep,ev,re,r,rp)
    Duel.SortDecktop(tp,tp,e:GetLabel())
end
function c501001050.tdcost(e,tp,eg,ep,ev,re,r,rp,chk)
        if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
        e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c501001050.tdtarget(e,tp,eg,ep,ev,re,r,rp,chk)
        if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0 end
end
function c501001050.tdoperation(e,tp,eg,ep,ev,re,r,rp)
        local ct=Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)
        if ct==0 then return end
        if ct>3 then ct=3 end
        local t={}
        for i=1,ct do t[i]=i end
        Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(501001050,1))
        local ac=Duel.AnnounceNumber(tp,table.unpack(t))
        Duel.ConfirmDecktop(tp,ac)
        local g=Duel.GetDecktopGroup(tp,ac)
        local sg=g:Filter(Card.IsRace,nil,RACE_PLANT)
        if sg:GetCount()>0 then
            Duel.DisableShuffleCheck()
            Duel.SendtoGrave(sg,REASON_EFFECT+REASON_REVEAL)
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOHAND)
			local rg=Duel.SelectMatchingCard(tp,Card.IsAbleToHand,tp,LOCATION_ONFIELD,0,sg:GetCount(),sg:GetCount(),nil)
			Duel.HintSelection(rg)
			Duel.SendtoHand(rg,nil,REASON_EFFECT)
		end
        ac=ac-sg:GetCount()
        if ac>0 then
                Duel.SortDecktop(tp,tp,ac)
                for i=1,ac do
                        local mg=Duel.GetDecktopGroup(tp,1)
                        Duel.MoveSequence(mg:GetFirst(),1)
                end
        end
end

