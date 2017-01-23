--ビーストアイズ・ペンデュラム・ドラゴン
function c511002808.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFun2(c,aux.FilterBoolFunction(Card.IsFusionSetCard,0xf2),aux.FilterBoolFunction(Card.IsRace,RACE_BEAST),true)
	--damage
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_DAMAGE)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetCode(EVENT_BATTLE_DESTROYING)
	e3:SetCondition(c511002808.damcon)
	e3:SetTarget(c511002808.damtg)
	e3:SetOperation(c511002808.damop)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_SPSUMMON_SUCCESS)
	e4:SetOperation(c511002808.valcheck)
	e4:SetLabelObject(e3)
	c:RegisterEffect(e4)
end
function c511002808.damcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	return c:IsRelateToBattle() and bc:IsType(TYPE_MONSTER)
end
function c511002808.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local dam=e:GetLabel()
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(dam)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,dam)
end
function c511002808.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
function c511002808.valcheck(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=c:GetMaterial():Filter(Card.IsRace,nil,RACE_BEAST)
	local atk=0
	if g:GetCount()>0 and bit.band(c:GetSummonType(),SUMMON_TYPE_FUSION)==SUMMON_TYPE_FUSION then
		local tc=g:GetFirst()
		if tc:GetPreviousControler()==c:GetControler() and tc:IsPreviousLocation(LOCATION_ONFIELD) then
			atk=tc:GetTextAttack()
		end
		if atk<0 then atk=0 end
	end
	e:GetLabelObject():SetLabel(atk)
end
