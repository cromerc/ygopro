--武神帝－スサノヲ
function c805000057.initial_effect(c)
	c:SetUniqueOnField(1,0,805000057)
	--xyz summon
	aux.AddXyzProcedure(c,aux.XyzFilterFunctionF(c,aux.FilterBoolFunction(Card.IsSetCard,0x86),4),2)
	c:EnableReviveLimit()
	--attack all
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_ATTACK_ALL)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--search
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetCountLimit(1)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCost(c805000057.cost)
	e2:SetTarget(c805000057.target)
	e2:SetOperation(c805000057.operation)
	c:RegisterEffect(e2)
end
function c805000057.dscon(e)
	return e:GetHandler():GetOverlayCount()~=0
end
function c805000057.sumlimit(e,c,sump,sumtype,sumpos,targetp)
	return c:IsLevelAbove(5)
end
function c805000057.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c805000057.filter(c)
	return c:IsSetCard(0x86) and (c:IsAbleToHand() or c:IsAbleToGrave())
end
function c805000057.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c805000057.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c805000057.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectMatchingCard(tp,Card.IsSetCard,tp,LOCATION_DECK,0,1,1,nil,0x86)
	local gt1=g:Filter(Card.IsAbleToHand,nil)
	local gt2=g:Filter(Card.IsAbleToGrave,nil)
	local opt=nil
	if gt1:GetCount()>0 and gt2:GetCount()>0 then	
		opt=Duel.SelectOption(tp,aux.Stringid(110000000,3),aux.Stringid(110000000,4))
	else 
		if gt1:GetCount()>0 and gt2:GetCount()==0 then
			opt=0
		else
			if gt1:GetCount()==0  and gt2:GetCount()==0 then
				return false
			else 
				opt=1
			end
		end
	end
	if opt==0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	else	
		Duel.SendtoGrave(g,REASON_EFFECT)
	end
end