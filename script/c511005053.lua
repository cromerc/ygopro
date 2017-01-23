--Galaxy Shot
--  By Shad3

local scard=c511005053

function scard.initial_effect(c)
	--Act
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetTarget(scard.tg)
	e1:SetOperation(scard.op)
	c:RegisterEffect(e1)
	--Equip limit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_EQUIP_LIMIT)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetValue(scard.eq_lmt)
	c:RegisterEffect(e2)
	--Trb
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_BATTLE_DAMAGE)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCategory(CATEGORY_DAMAGE)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetCondition(scard.dm_cd)
	e3:SetTarget(scard.dm_tg)
	e3:SetOperation(scard.dm_op)
	c:RegisterEffect(e3)
end

function scard.fil(c)
	return c:IsFaceup() and c:IsSetCard(0x107b)
end

function scard.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:GetLocation()==LOCATION_MZONE and scard.fil(chkc) end
	if chk==0 then return Duel.IsExistingTarget(scard.fil,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,scard.fil,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end

function scard.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() and c:IsRelateToEffect(e) then
		Duel.Equip(tp,c,tc)
	end
end

function scard.eq_lmt(e,c)
	return c:IsSetCard(0x107b)
end

function scard.dm_cd(e,tp,eg,ep,ev,re,r,rp)
	return tp~=ep and eg:GetFirst()==e:GetHandler():GetEquipTarget()
end

function scard.dm_tg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler():GetEquipTarget()
	if chk==0 then return c:IsReleasable() end
	local atk=c:GetAttack()
	Duel.Release(c,REASON_COST)
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(atk)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,atk)
end

function scard.dm_op(e,tp,eg,ep,ev,re,r,rp)
	local p,dmg=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,dmg,REASON_EFFECT)
end