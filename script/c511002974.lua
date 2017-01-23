--Gladiator Beast Fort
function c511002974.initial_effect(c)
	c:RegisterFlagEffect(511002973,0,0,0)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--attach
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(19310321,0))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c511002974.gbcon)
	e2:SetTarget(c511002974.gbtg)
	e2:SetOperation(c511002974.gbop)
	c:RegisterEffect(e2)
	--damage
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(17415895,0))
	e3:SetCategory(CATEGORY_DAMAGE)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetCountLimit(1)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCost(c511002974.damcost)
	e3:SetTarget(c511002974.damtg)
	e3:SetOperation(c511002974.damop)
	c:RegisterEffect(e3)
	--target
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(82962242,0))
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e4:SetCountLimit(1)
	e4:SetType(EFFECT_TYPE_QUICK_O)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCode(EVENT_FREE_CHAIN)
	e4:SetTarget(c511002974.tgtg)
	e4:SetOperation(c511002974.tgop)
	c:RegisterEffect(e4)
	--battle
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_QUICK_F)
	e5:SetRange(LOCATION_SZONE)
	e5:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e5:SetCondition(c511002974.btcon)
	e5:SetTarget(c511002974.bttg)
	e5:SetOperation(c511002974.btop)
	c:RegisterEffect(e5)
	--effect
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_QUICK_F)
	e6:SetRange(LOCATION_SZONE)
	e6:SetCode(EVENT_BECOME_TARGET)
	e6:SetTarget(c511002974.efftg)
	e6:SetOperation(c511002974.effop)
	c:RegisterEffect(e6)
end
function c511002974.gbcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetOverlayCount()==0
end
function c511002974.gbfilter(c)
	return c:IsSetCard(0x19) and c:IsType(TYPE_MONSTER)
end
function c511002974.gbtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511002974.gbfilter,tp,LOCATION_DECK,0,1,nil) end
end
function c511002974.gbop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local g=Duel.SelectMatchingCard(tp,c511002974.gbfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.Overlay(c,g)
	end
end
function c511002974.damcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=e:GetHandler():GetOverlayGroup()
	if chk==0 then return g:IsExists(Card.IsAbleToDeckAsCost,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local sg=g:FilterSelect(tp,Card.IsAbleToDeckAsCost,1,1,nil)
	Duel.SendtoDeck(sg,nil,2,REASON_COST)
end
function c511002974.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(1000)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,1000)
end
function c511002974.damop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
function c511002974.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x19) and c:GetFlagEffect(511002974)==0 and c:GetFlagEffect(511002975)==0 
		and c:GetFlagEffect(511002972)==0 and c:GetFlagEffect(511002973)==0
end
function c511002974.tgtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c511002974.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511002974.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local tc=Duel.SelectTarget(tp,c511002974.filter,tp,LOCATION_MZONE,0,1,1,nil):GetFirst()
	local op=0
	if tc then
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(76922029,0))
		if tc:GetFlagEffect(511002974)==0 and tc:GetFlagEffect(511002975)==0 then
			op=Duel.SelectOption(tp,aux.Stringid(77700347,0),aux.Stringid(50789693,1))
		elseif tc:GetFlagEffect(511002974)==0 then
			Duel.SelectOption(tp,aux.Stringid(77700347,0))
			op=0
		else
			Duel.SelectOption(tp,aux.Stringid(50789693,1))
			op=1
		end
		if op==0 then
			tc:RegisterFlagEffect(511002972,RESET_CHAIN,0,0)
		else
			tc:RegisterFlagEffect(511002973,RESET_CHAIN,0,0)
		end
	end
end
function c511002974.tgop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		if tc:GetFlagEffect(511002972)>0 then
			tc:RegisterFlagEffect(511002974,RESET_EVENT+0x1fe0000,0,0)
		elseif tc:GetFlagEffect(511002973)>0 then
			tc:RegisterFlagEffect(511002975,RESET_EVENT+0x1fe0000,0,0)
		end
	end
end
function c511002974.btcon(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	return d and (a:GetFlagEffect(511002974)>0 or d:GetFlagEffect(511002974)>0)
end
function c511002974.bttg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:GetFlagEffect(511002974)==0 end
	c:RegisterFlagEffect(511002974,RESET_CHAIN,0,1)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	local g=Group.CreateGroup()
	if a:GetFlagEffect(511002974)>0 then g:AddCard(a) end
	if d:GetFlagEffect(511002974)>0 then g:AddCard(d) end
	Duel.SetTargetCard(g)
end
function c511002974.btop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	if c:IsRelateToEffect(e) then
		local tc=g:GetFirst()
		while tc do
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
			e1:SetValue(1)
			e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
			tc:RegisterEffect(e1)
			local e2=Effect.CreateEffect(c)
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
			e2:SetValue(1)
			e2:SetReset(RESET_PHASE+PHASE_DAMAGE)
			tc:RegisterEffect(e2)
			tc=g:GetNext()
		end
	end
end
function c511002974.cfilter(c)
	return c:GetFlagEffect(511002975)>0
end
function c511002974.efftg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c511002974.cfilter,1,nil) end
	local g=eg:Filter(c511002974.cfilter,nil)
	Duel.SetTargetCard(g)
end
function c511002974.effop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	if c:IsRelateToEffect(e) then
		local tc=g:GetFirst()
		while tc do
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
			e1:SetValue(c511002974.indesval)
			e1:SetReset(RESET_CHAIN)
			e1:SetLabelObject(re)
			tc:RegisterEffect(e1)
			tc=g:GetNext()
		end
	end
end
function c511002974.indesval(e,re)
	return re==e:GetLabelObject()
end
