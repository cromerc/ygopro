--メタルフォーゼ・オリハルク
function c28016193.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e0:SetCode(EFFECT_FUSION_MATERIAL)
	e0:SetCondition(c28016193.fscon)
	e0:SetOperation(c28016193.fsop)
	c:RegisterEffect(e0)
	--pierce
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_PIERCE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0xe1))
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c28016193.damcon)
	e2:SetOperation(c28016193.damop)
	c:RegisterEffect(e2)
	--destroy
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e3:SetCondition(c28016193.descon)
	e3:SetTarget(c28016193.destg)
	e3:SetOperation(c28016193.desop)
	c:RegisterEffect(e3)
end
function c28016193.filter(c)
	return (c:IsFusionSetCard(0xe1) or c:IsHasEffect(511002961)) and not c:IsHasEffect(6205579)
end
function c28016193.check1(c,mg,chkf)
	return mg:IsExists(c28016193.check2,1,c,c,chkf)
end
function c28016193.check2(c,c2,chkf)
	local g=Group.FromCards(c,c2)
	if g:IsExists(aux.TuneMagFusFilter,1,nil,g,chkf) then return false end
	local g1=g:Filter(c28016193.filter,nil)
	if chkf~=PLAYER_NONE then
		return g1:FilterCount(aux.FConditionCheckF,nil,chkf)~=0 and g1:GetCount()>=2
	else return g1:GetCount()>=2 end
end
function c28016193.fscon(e,g,gc,chkfnf)
	if g==nil then return true end
	local chkf=bit.band(chkfnf,0xff)
	local tp=e:GetHandlerPlayer()
	local fg=Duel.GetMatchingGroup(Card.IsHasEffect,tp,LOCATION_MZONE,0,nil,77693536)
	local fc=fg:GetFirst()
	while fc do
		g:Merge(fc:GetEquipGroup():Filter(Card.IsControler,nil,tp))
		fc=fg:GetNext()
	end
	local mg=g:Filter(Card.IsCanBeFusionMaterial,nil,e:GetHandler(),true)
	if gc then
		if not gc:IsCanBeFusionMaterial(e:GetHandler(),true) then return false end
		return c28016193.check1(gc,mg,chkf)
	end
	return mg:IsExists(c28016193.check1,1,nil,mg,chkf)
end
function c28016193.fsop(e,tp,eg,ep,ev,re,r,rp,gc,chkfnf)
	local chkf=bit.band(chkfnf,0xff)
	local fg=Duel.GetMatchingGroup(Card.IsHasEffect,tp,LOCATION_MZONE,0,nil,77693536)
	local fc=fg:GetFirst()
	while fc do
		eg:Merge(fc:GetEquipGroup():Filter(Card.IsControler,nil,tp))
		fc=fg:GetNext()
	end
	local g=eg:Filter(Card.IsCanBeFusionMaterial,nil,e:GetHandler(),true)
	local p=tp
	local sfhchk=false
	if Duel.IsPlayerAffectedByEffect(tp,511004008) and Duel.SelectYesNo(1-tp,65) then
		p=1-tp Duel.ConfirmCards(1-tp,g)
		if g:IsExists(Card.IsLocation,1,nil,LOCATION_HAND) then sfhchk=true end
	end
	if gc then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
		local g1=g:FilterSelect(p,c28016193.check2,1,1,gc,gc,chkf)
		if sfhchk then Duel.ShuffleHand(tp) end
		Duel.SetFusionMaterial(g1)
		return
	end
	Duel.Hint(HINT_SELECTMSG,p,HINTMSG_FMATERIAL)
	local g1=g:FilterSelect(p,c28016193.check1,1,1,nil,g,chkf)
	local tc1=g1:GetFirst()
	Duel.Hint(HINT_SELECTMSG,p,HINTMSG_FMATERIAL)
	local g2=g:FilterSelect(p,c28016193.check2,1,1,tc1,tc1,chkf)
	g1:Merge(g2)
	if sfhchk then Duel.ShuffleHand(tp) end
	Duel.SetFusionMaterial(g1)
end
function c28016193.damcon(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	return ep~=tp and tc:IsSetCard(0xe1) and tc:GetBattleTarget()~=nil and tc:GetBattleTarget():IsDefensePos()
end
function c28016193.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(ep,ev*2)
end
function c28016193.descon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c28016193.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_ONFIELD) end
	if chk==0 then return Duel.IsExistingTarget(aux.TRUE,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,aux.TRUE,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c28016193.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
